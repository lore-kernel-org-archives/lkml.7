Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EA5C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A810C218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562162794;
	bh=EQE2AB00UJwl1CmyF0ZvFrESw4yDTpobY4maUeEVR7w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QysaGG4jBJz+0+CPfcgZq7LnoAiznPzaJYZnIl+RAdW/rgMFRHucu6cut2llXl5JP
	 7Yimt918/g85yQ662D4GKJs6q64BRAz3wBucLAzPmAYy5oPmjeuDfNtzsMlds8hEB5
	 6emM/1nT5KSbOSJnNcomGWSPPsbfC4Ca4nq+9Tb0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfGCOGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:06:33 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37849 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfGCOGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:06:32 -0400
Received: by mail-ed1-f65.google.com with SMTP id w13so2229939eds.4;
        Wed, 03 Jul 2019 07:06:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EQE2AB00UJwl1CmyF0ZvFrESw4yDTpobY4maUeEVR7w=;
        b=G3CAvAjocAfAQRir7gq72jKW5PylYRhrB3+8Dd07VotfcJPQyDQik8mca+Upw7lYC0
         +XkPdR/yzfUzjPN3VI6lCT15Yc58aZxbCBPu3zbyw2frp9OVWYe1j9jrNumxYfI79lQD
         f/JUbNmKajm3iDr4JQkZ1GTE36CCWwRLYCyBzSNzaOW7UD3cvsGsrcHGz+lnWLiXV6+v
         VlrJ1az3zbqlZsWDohsU8iRbFbXNAW2XuW8j+IyRatTINC9l4x4+RvYnB5aEfUfQlkQg
         K29tw8LThw4DC7+qrfeFpS0Nb+AUZgiDCW3i/Ay4Q7HEnb1n59R672IccH4fKF7PsNmb
         O04g==
X-Gm-Message-State: APjAAAVhRdZ//67ezOhYt7yCvRsOlWj+heXKaaKMy4Kdg2gE89NJ04vf
        /Ve2VWbJns97jByHd2dcrzOlj2VzVqhCCYg9lhXU2o/W
X-Google-Smtp-Source: APXvYqz/rXKE6GzLTqkAWS9E8zUyxS+aktUOHYbeJBTlYcE7ngS8LHrt6vsxluFJYFhNK8lzRxgFWhtB0bTCbItT1Xk=
X-Received: by 2002:a50:9871:: with SMTP id h46mr42642796edb.69.1562162790944;
 Wed, 03 Jul 2019 07:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190626223851.19138-1-srinivas.pandruvada@linux.intel.com>
 <20190626223851.19138-11-srinivas.pandruvada@linux.intel.com>
 <CAHp75VfMDpKyYnZkZw51dwcEt5neQwGuZUaB7yEFQW6fjRYCqg@mail.gmail.com>
 <CAJvTdK=S1vPGg9HZjUxJN2aXSfSXBDyYYLawONA0PP_yKvf19A@mail.gmail.com> <CAHp75VfY+u4L85VncaLYFcoFwa0OzTo__ZKZGboRXmyQ50mCOA@mail.gmail.com>
In-Reply-To: <CAHp75VfY+u4L85VncaLYFcoFwa0OzTo__ZKZGboRXmyQ50mCOA@mail.gmail.com>
From:   Len Brown <lenb@kernel.org>
Date:   Wed, 3 Jul 2019 10:06:19 -0400
Message-ID: <CAJvTdKkZjzD_TgyZ_VGZHTQr-07va91faSWB_SSRCRyp-qAejg@mail.gmail.com>
Subject: Re: [PATCH 10/10] tools/power/x86: A tool to validate Intel Speed
 Select commands
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Andriy Shevchenko <andriy.shevchenko@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alan Cox <alan@linux.intel.com>,
        Prarit Bhargava <prarit@redhat.com>,
        David Arcari <darcari@redhat.com>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I hope this is applicable for v2.

Yes, Srinivas is doing the right thing.

thanks,
-Len


> > Acked-by: Len Brown <len.brown@intel.com>
