Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DDAC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B88AC2077C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573145532;
	bh=Z1dqk+RRh5Tw9vIdgN632bDR4HOjWiROuyE5KZkrIOc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bBr/7La6aO58bGzsVYoQfRODjhYU9WFgentuS5/R+JHOT6nb2Xv3WgjHg2QLng0FG
	 wyZ6gVYfAaHIHsruQrbwCI6pvcPz21PCbs8EU6ZITIV1Rn5CuBsO2wzFaAHMx/Vd7j
	 sdeR29m6jPKv3MmyGYidmz7C0TdKT1q2mwuilODI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388654AbfKGQwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 11:52:11 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44673 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfKGQwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 11:52:11 -0500
Received: by mail-lf1-f67.google.com with SMTP id v4so2113331lfd.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 08:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QmbLva0bcejWfZ5vroXCCCNjtDh9+KzeuzRfAkUcNVw=;
        b=RC+2jxnet1c9HEhXNBxtTTpEfLinckdbFJn5Bmrik3m/W7Num2OjpLxTQS23AoRNRr
         Aj4dYDnclnksK9me7oG5iyDsfchGPA4TwVOyMbOGN2PJFpJroPg+VNW7luk63nWV0aoz
         X/nFl5ue/aQhw5K+6Ogz8TNi8yWG86H2/HKz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QmbLva0bcejWfZ5vroXCCCNjtDh9+KzeuzRfAkUcNVw=;
        b=cpM+rzVTlJYtg1/AahGooV0c2VSjlgJoDHK8eqwv3BtoV0pvxmmqh+Ur8DwwxuN9Nm
         6h01kAGsenOv8e2FW9AOnbYs71mB4XKn0y3FRYa+WGV965kN4SRBekYoW79vef2Z26Qp
         tp8PZCdRDBBKrXAxhWCnLfAqVvqi0cnGXSCSQQopaXmWRd1U18ewPpR4GWreqytoYxXL
         3rm1OMGKsauWg1Li9vcBAAe20hWoMbTX0tjn0fl1ztQ5r41l3Sddpifp7uMN6fIg2f5+
         mywLS7oos83o5nwtPc758DXZoOTM7Al5QZi1blcrTsALJU5OLyjr+PAOoOy8SxCXeFH/
         4juA==
X-Gm-Message-State: APjAAAWqPGk1g7/YXCUhpqYpw5WTpEUS5575QXTwttIoONL05CGM9RPo
        PYgaRxIozdsDgigSjdX3OBQoEKVZYWY=
X-Google-Smtp-Source: APXvYqyYR9p0KeMElPR7T5TyL8f9S9nsu0EJuVvg2WnsuqBLhr96xh8s5hpqi9/bAxYqZyjCDxxqvg==
X-Received: by 2002:a19:655b:: with SMTP id c27mr3013952lfj.122.1573145528612;
        Thu, 07 Nov 2019 08:52:08 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id c22sm1550232lfj.28.2019.11.07.08.52.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2019 08:52:07 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id f5so2154696lfp.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 08:52:06 -0800 (PST)
X-Received: by 2002:ac2:5bca:: with SMTP id u10mr3159115lfn.134.1573145526683;
 Thu, 07 Nov 2019 08:52:06 -0800 (PST)
MIME-Version: 1.0
References: <157262967752.13142.696874122947836210.stgit@warthog.procyon.org.uk>
 <20191107090306.GV29418@shao2-debian>
In-Reply-To: <20191107090306.GV29418@shao2-debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Nov 2019 08:51:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiJ+jaT5Ev-wCg7iGNNO_JFUyMDcat0KDdA2b_+n_cZCQ@mail.gmail.com>
Message-ID: <CAHk-=wiJ+jaT5Ev-wCg7iGNNO_JFUyMDcat0KDdA2b_+n_cZCQ@mail.gmail.com>
Subject: Re: [pipe] d60337eff1: phoronix-test-suite.noise-level.0.activity_level
 144.0% improvement
To:     lkp report check <rong.a.chen@intel.com>
Cc:     David Howells <dhowells@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 1:03 AM lkp report check <rong.a.chen@intel.com> wrote:
>
> FYI, we noticed a 144.0% improvement of phoronix-test-suite.noise-level.0.activity_level due to commit:
>
> commit: d60337eff18a3c587832ab8053a567f1da9710d2 ("[RFC PATCH 04/11] pipe: Use head and tail pointers for the ring, not cursor and length [ver #3]")

That sounds nice, but is odd. That commit really shouldn't change
anything noticeable. David, any idea?

               Linus
