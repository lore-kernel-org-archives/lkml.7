Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84070C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 19:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF7221479
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 19:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558468186;
	bh=+lvuTAsuVvCk6ShySSosDXEuWDpgzXa2ff6M/w268BY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CI8nKovtmQTDVNtx8Dmz6vEdBlDlKX06eutFX/RMqUOjEPM1okqWsZNaAOSf5oSoy
	 1BaWJpgpqKx8TdKvGLPoU/OEEu7O7EYguLtIbwfsVrQg1n5Ao6b+PxHYD6Y0cNdEH+
	 l41tHdjIpR7FeI6lNRktFS/xqUJmydomRm+ZZ3nw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfEUTtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 15:49:45 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:43354 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfEUTtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 15:49:45 -0400
Received: by mail-lf1-f50.google.com with SMTP id u27so14008217lfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 12:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KbAeX3ULgAw+48diKoVE4ufJ3FnxC/sO5bPiY1VSwg8=;
        b=E+UYvhcXOQje8KyA+0nTfTI82/b4+Lq8UVwM13n9yGNLe15UMzG3NRe3XVXlxMmX+F
         /cjPdhV25Qyg9L7P90WLjoq2WReCfOgQK/AouRPXUOpPxsAk5RSXRQQGaiHvef/++IIv
         PUdDHUh5Plvk1f2CC0dmA8AzYpOjX9R4b/Ag4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KbAeX3ULgAw+48diKoVE4ufJ3FnxC/sO5bPiY1VSwg8=;
        b=g4YkDhf0TFukgJxE8ixRldutCpPcqDA3LzbGwmxgBlxB/o8R3jFq3+rjUd4G+hBDhz
         1PUjXQ6SwfhvPQyYlpHprEh91fk2XWlyl+3reI4nRvVk9c5/PJE8BPgTOZocJvomwCeF
         j6nBX1QzuNonlMuhY6ZmdexhTK3ogxal4yW10tml2UnSCusPXgos3fG4KzEY2jVwe2DL
         IJYtDeY2QlH2mnq/foE7JDTOt2oeAsPPoYo5EuNn6f6JCQVI/tKsuEuIX1QHP/YFpDQ7
         8mTpVyh2vTw+LBuyA8Jsl7OJhSOIcIaJN8vxlQFxl8XvqNMRK8rG26nNeLDZ+OACUqrZ
         FGsQ==
X-Gm-Message-State: APjAAAWNjwmwM/X7MpAsLtHJqJaAjnjd93Xj/sehjGzBaBY3VP3GXkZL
        ABzFBq/P6C0PMo1h3I73UbbX7LhYSEk=
X-Google-Smtp-Source: APXvYqw8TjMYuUeK+nyifg7K0PXGGJDLzaJ7AovLEx2POh8guQLq2xi3QNTadavOfVl28hRYIWKHhQ==
X-Received: by 2002:a19:c194:: with SMTP id r142mr42250518lff.41.1558468182534;
        Tue, 21 May 2019 12:49:42 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id d17sm3295659lfa.4.2019.05.21.12.49.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 12:49:41 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id j24so17034365ljg.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 12:49:41 -0700 (PDT)
X-Received: by 2002:a2e:6c0b:: with SMTP id h11mr7174324ljc.15.1558468181175;
 Tue, 21 May 2019 12:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190521162350.GA17107@osiris>
In-Reply-To: <20190521162350.GA17107@osiris>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 May 2019 12:49:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgCtFPj_Uo1RMHnCLHut8SRG_t5M-E8Uw2+OFmc=c=H6w@mail.gmail.com>
Message-ID: <CAHk-=wgCtFPj_Uo1RMHnCLHut8SRG_t5M-E8Uw2+OFmc=c=H6w@mail.gmail.com>
Subject: Re: Sad News - Martin Schwidefsky
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 9:24 AM Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:
>
> We are devastated by the tragic death of Martin Schwidefsky who died
> in an accident last Saturday.

Ouch.

Thanks for letting people know, and condolences to friends and family.

               Linus
