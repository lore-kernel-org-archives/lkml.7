Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C77C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244EA206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="QFhl7FGH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfLJUHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:07:33 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46277 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfLJUHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:07:32 -0500
Received: by mail-oi1-f193.google.com with SMTP id a124so10988077oii.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 12:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uQ5MRu7eBmHm6OUR1kwdbNENkUMzLBkNbzI6ewewfew=;
        b=QFhl7FGH4yA/EbDNh1tBvUtjp++JicNkBw3DI3RZqee01B04Au/qmKS3Xhe1MHcy4O
         ECOdiTwlIsP+XNKNVO15a4iowSTfQeQ/g2wtPzddiGndpmXwL30rHoIVk3OcgT5+KHFL
         mV4d4CyJIKaRjL6KBD6PxtcxGo8Lhq0fRDs6IWX5zPTuVPRGUAu2VvwLgMK7nSCpDgI5
         VvJ3FWJa/UsBY8xavAWhFP7VMuhS0FxHMiNEvEx6JRnEHKEG4odz+hhxRaKipFMLCNXF
         TJxFrCwWn8XjhXw+ZZHjWfv7ZBvqQTKMqpyfxyap6U7Ri+65xeqpPwIXvGcW1TLOg76b
         Y+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uQ5MRu7eBmHm6OUR1kwdbNENkUMzLBkNbzI6ewewfew=;
        b=K0OBAGQC7ZI+XEvHNTy2jYCdTbwwaQ72YQN35XBaMWNVLIkbnAwY0jwpAFmChy2ZX9
         o9FtjBwA97ArCRI+zxlXt5x9LBFQdrk2VDUXVJ9H59WFYCbCUn8Ol5opNGLZYfkryioR
         PLQpQbOzTHMOGcvWGbOOkxDo1AJgdj3viNvUjgvED3ljoMJGp26YafAHA9xwXh4PzP7q
         j1vEnw3774vgH0s8dMSdx9petqYuYQbwpAiwe5xcnqzUKnqo6IRSqVijr7VLA5I1ioqj
         3Ns/4OUrsSTXE8KgrlFrUIzG9XFcYtP3/xRnCypf0LlkWdIyHVnnwZs3pAsySY7bE4dj
         BwqQ==
X-Gm-Message-State: APjAAAW42tpeJqSTOA/prsj3mIvHUB3fk6KQaqhLkzG77DkxyjqdZgOI
        jhIZdae9CtKhoL37DW8ov8uO3cIyEv4=
X-Google-Smtp-Source: APXvYqz5nQOo/8Xd2Gow6+zdGyPViUZp2xjc9+dGPEHwXmsSqAF5+nQC6/w6YTilfrBBZnw6M4SOTg==
X-Received: by 2002:a05:6808:210:: with SMTP id l16mr597004oie.95.1576008451827;
        Tue, 10 Dec 2019 12:07:31 -0800 (PST)
Received: from ?IPv6:2605:6000:e947:6500:6680:99ff:fe6f:cb54? ([2605:6000:e947:6500:6680:99ff:fe6f:cb54])
        by smtp.googlemail.com with ESMTPSA id m2sm1728359oim.13.2019.12.10.12.07.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 12:07:31 -0800 (PST)
Subject: Re: [PATCH][resend] sh: kgdb: Mark expected switch fall-throughs
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Will Deacon <will@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Paul Burton <paul.burton@mips.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
References: <87muc1yqip.wl-kuninori.morimoto.gx@renesas.com>
From:   Rob Landley <rob@landley.net>
Message-ID: <4b099e66-973a-8e75-9f62-801fc3b2f594@landley.net>
Date:   Tue, 10 Dec 2019 14:10:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87muc1yqip.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/19 6:26 PM, Kuninori Morimoto wrote:
> 
> Hi Greg
> 
> I'm posting this patch from few month ago,
> but it seems SH ML maintainer is not working in these days...

There's two of them and they both are? (I spoke to Rich on IRC last week?)

Rob
