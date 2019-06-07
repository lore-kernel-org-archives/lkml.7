Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4E6C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EBD7208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559929069;
	bh=BvmOLjYcuZElA1Af8GOkxDtOYEio/s3s5NjEsbuNNvY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ymbzW2aO5zFNS7JViFJtxUo34rOCyy4XV7g4JVhwOb93O8ScBNIL+wc3E7prXR0pC
	 dJjCQ5IK9IYTPwxdNpDSiJKGbNYbvD1KNGWpXCsSXR9P4CryN+lbimQduRlyyXKLlJ
	 yYOY5i1EeGrFjmWoyrTqfE+cIklFzLBd9S9ANpI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbfFGRhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 13:37:48 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36405 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728727AbfFGRhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 13:37:47 -0400
Received: by mail-lf1-f67.google.com with SMTP id q26so2246000lfc.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 10:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MSG4wmf4DZg3pboc2cPfiOvBY7zuLccj9JHi0EsZxVk=;
        b=MUkBsotWFEougFeyAN0sHZjosPDI8bGTyK7DrUtVnNt+RarGD3A2vBUgrWQoQAHvom
         eHs41SMCR/XhfKupzJQkg9e5FhfiSy+kthIeLQBJswVxPw7/VCM6LkJ5ydDrkh5fWnWQ
         uqRsxdg7SmP0WGHgIyVfjXaPRCpKQ2t8gQwas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MSG4wmf4DZg3pboc2cPfiOvBY7zuLccj9JHi0EsZxVk=;
        b=ZmNlceYohh503Kp9wXPr0wGrslvFGNLZknbOnXOzvWT8g5QlOjWcqEvierR+BFvRod
         zD0pjobHo3BIYO20yFQEWb81mh2oXpv3G5Nh6E4qzKToxk7ARNqT9KWgrG+53q8IHmEn
         tOeL5eKSXCpfdehDwdJg+qIVZwr+iQURJ+Ke7JavqwqoTd0W35as2RkYoQ/CGE6Wi3fr
         NpK/yJFZQ+BnUx2Y4YWZ7IyufQrsB8CjoWWZwIO77SvsjocDKFdzfx7T559qSE3MsV10
         +Fa6e6eozfBVPmADdj6SvutH7PzFUQZGsIWzOPFuSbysK3w9Ekia751cnKCPM/w68DSk
         zhGw==
X-Gm-Message-State: APjAAAVjB63Of+1hE06s6wmEFL9iq5Jxnto/OtYjHZ8LupzF7O4desEP
        IQbG7UiyU6xBVrnb48knCcF3Bsj42ro=
X-Google-Smtp-Source: APXvYqzgTOrN5TdP2ZVCOV6/FlvSZedUH+yt4w3wl109J8fnaFBW3+8XcUnv7VM24Yp0VC11MXDkrQ==
X-Received: by 2002:ac2:5446:: with SMTP id d6mr26921350lfn.138.1559929065702;
        Fri, 07 Jun 2019 10:37:45 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id w8sm515743lfq.62.2019.06.07.10.37.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 10:37:45 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id m15so2424656ljg.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 10:37:44 -0700 (PDT)
X-Received: by 2002:a2e:4246:: with SMTP id p67mr28794501lja.44.1559929063460;
 Fri, 07 Jun 2019 10:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190607103122.GA22167@redhat.com> <20190607103154.GA22159@redhat.com>
 <CAHk-=wjzU4MmVomodhTVSWnKUxKOBpvhdXgf1_riBtSwZuwMSg@mail.gmail.com>
In-Reply-To: <CAHk-=wjzU4MmVomodhTVSWnKUxKOBpvhdXgf1_riBtSwZuwMSg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Jun 2019 10:37:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wif34nPB2uzU2YBXXYe5cFZhoLmU_zOtExd74X1WcYXJg@mail.gmail.com>
Message-ID: <CAHk-=wif34nPB2uzU2YBXXYe5cFZhoLmU_zOtExd74X1WcYXJg@mail.gmail.com>
Subject: Re: [PATCH 1/2] aio: simplify the usage of restore_saved_sigmask_unless()
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Laight <David.Laight@aculab.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Eric Wong <e@80x24.org>, linux-aio@kvack.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 7, 2019 at 10:33 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Are they actually nonrestartable? I think the current EINTR is just a mistake.

Oh, I guess they are, because of the relative timeout thing that
shouldn't reset to the original value.

And I don't think this is worth a ERESTAR_RESTARTTBLOCK.

          Linus
