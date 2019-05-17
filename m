Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C5DC04E84
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 17:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9897A2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 17:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="h+8kfPwU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbfEQRZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 13:25:03 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39330 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfEQRZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 13:25:03 -0400
Received: by mail-ed1-f68.google.com with SMTP id e24so11615326edq.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 10:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KwxwPmgRkigdfsb2Wkb3RXFjzIqZbXV/qcyPm1HcIzw=;
        b=h+8kfPwUUJsUPbqk+gDlpRaeblBYE2fVW4Jl93m9L3oQKmknNCCYpao0UAd7gBMUks
         hPvzLnV7CdDh1/rNOvJ7v46flOg1P7P7cz6XzbCBCYHErwbjvAFHO8kAhowextIXP4K4
         wzyiG8+QdxKuZNzJAzTPlvWNsDUXruxytbe9VLr0sdzVqplAx0E4U5nvXrgAe4wbMxl6
         QCdQFy8r/2NXOgZ7Bbo8ZNYPwRVsY0c/6q0Ka037S0t7VHH6Oc7AMl/o6AVCy4Fohq/H
         1yjg5kwJzWMAQJFZgNugwf1zgUhfH+A3fbYIKv1b5n1rqomPr0aaze9q+ODnrQSUr8zZ
         LBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KwxwPmgRkigdfsb2Wkb3RXFjzIqZbXV/qcyPm1HcIzw=;
        b=NFnlPsJWusUDWfbOeajAbL/ulZCXqMIqDlviadJzhtbXvvQktPBMp0qC3XRtd/fQ+3
         LtZ3Uluan+Jgoik1uIA078OH685yuFg7PXGN61pvlzibG5UJ+thXb273657SB6w6M9up
         nwY+Wr389jcdnAgmiFhnU+guXv9q5o/ho+HLI6fuYEfHXJV4kSsS3W5rDKk/GNcBKKjx
         QEc3MxiWRzJmrSt2os//g8SYgJvXgz3ohxPg5NLa0YQmc6AkiOJqAuCncji0F+FPtdc7
         iUVJVZkH5ZS5vpabqgDBMtHPEOeKZgh8436GglCLKPcgUieqzv7G5CH9tX/MUo93io5i
         A0CA==
X-Gm-Message-State: APjAAAULWaJ0RFv1c81zP2tjwzxo22ikXWK2t7OmPRB+ixcesRQfsufg
        j/Ifdi7BisGJ0jPVK2Ro6SHZFraKb1pDL2u/+EfUqQ==
X-Google-Smtp-Source: APXvYqwuyoSofrRAesux3TtniZbFtgeLGQpt/aaMsVyOQkqGRmuP2nmCLcnqBJYgiPbnM95G5HbA4GXqURtKw0f2SUc=
X-Received: by 2002:a50:ec87:: with SMTP id e7mr58594743edr.126.1558113901537;
 Fri, 17 May 2019 10:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <CA+CK2bBeOJPnnyWBgj0CJ7E1z9GVWVg_EJAmDs07BSJDp3PYfQ@mail.gmail.com>
 <20190517143816.GO6836@dhcp22.suse.cz> <CA+CK2bA+2+HaV4GWNUNP04fjjTPKbEGQHSPrSrmY7HLD57au1Q@mail.gmail.com>
In-Reply-To: <CA+CK2bA+2+HaV4GWNUNP04fjjTPKbEGQHSPrSrmY7HLD57au1Q@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 17 May 2019 13:24:50 -0400
Message-ID: <CA+CK2bDq+2qu28afO__4kzO4=cnLH1P4DcHjc62rt0UtYwLm0A@mail.gmail.com>
Subject: Re: NULL pointer dereference during memory hotremove
To:     Michal Hocko <mhocko@kernel.org>
Cc:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>, "bp@suse.de" <bp@suse.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "zwisler@kernel.org" <zwisler@kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Wu, Fengguang" <fengguang.wu@intel.com>,
        "baiyaowei@cmss.chinamobile.com" <baiyaowei@cmss.chinamobile.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 1:22 PM Pavel Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Fri, May 17, 2019 at 10:38 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Fri 17-05-19 10:20:38, Pavel Tatashin wrote:
> > > This panic is unrelated to circular lock issue that I reported in a
> > > separate thread, that also happens during memory hotremove.
> > >
> > > xakep ~/x/linux$ git describe
> > > v5.1-12317-ga6a4b66bd8f4
> >
> > Does this happen on 5.0 as well?
>
> Yes, just reproduced it on 5.0 as well. Unfortunately, I do not have a
> script, and have to do it manually, also it does not happen every
> time, it happened on 3rd time for me.

Actually, sorry, I have not tested 5.0, I compiled 5.0, but my script
still tested v5.1-12317-ga6a4b66bd8f4 build. I will report later if I
am able to reproduce it on 5.0.

Pasha
