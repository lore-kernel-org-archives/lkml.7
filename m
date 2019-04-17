Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8896C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1AD7206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgUhS2QS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387408AbfDQSyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 14:54:25 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35769 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbfDQSyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 14:54:24 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so12456030plp.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 11:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/alwtP8uexc5/qbVbFxk1HzLZnaCzxDkUrTDe6UQRX8=;
        b=mgUhS2QS+qj85a7Zfb6cFoeg3UPJ4djxclyJDZz85OOl80UZFUMZyiREi7t3Q2KaAK
         F+VScXtrjHwJ0JSjSAXsGSib7dvtz/30U5uZZ6EZ4S93p6xMnUH7kPVboEFZicfEm2CO
         Rw5/mgu3yr798UWmbTUhNSOV1AYLuNay8h9bEEnqzo+sP7LmRI/V9usfKGa4Og8Lw25w
         TZHXIB3Dt5L2SnEbOY20NDuNwzlvhs9evf0L790iZbH0patdxHcf2XWZxBckLwaW3Zwf
         G0vliSfWKsmGQW1rz07iT+NagMhHP9eFwD/8JMioIQjb5wWeyTUw01J069q5Uv73WEZI
         OJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/alwtP8uexc5/qbVbFxk1HzLZnaCzxDkUrTDe6UQRX8=;
        b=k9vjcetTKYBZ/Sdr0m0EBzcHzi8Toy7ewApt2OvCz+54xNdanNgZjWpnIy1FxRxAFg
         Nk6cgV4cbS66tiFYSt5Y8vNg7JhkurJQXBIKVdDmlD3zRqJr836OMJo1brmbWg7pJwH0
         1TRbkyWTlHfP7vHyl6lEG94DuoPSDH/gVDSS4YiZS6C5yDPbhrNxJI5bSjfJpw7Ni7bB
         iJQctUSFDh5ERfphnHz+svq70py7++7BZmYNKuZ/YVZ6zze/s5i85wQkJ7pWao3hl/NY
         8Fgos9nuGjOPO9SK+dHZsCGOOWJU0zXtdtvowI9lEuEiMwfTdsrzW09tLgdMbFVihie8
         rQjw==
X-Gm-Message-State: APjAAAWvcHIXqNgGuvLYKtbnGKVI/8Vsh7QUOkOd+jQ+CBTv62jAevfy
        iGeUYyWdfciICzwy9C8/qa0=
X-Google-Smtp-Source: APXvYqxpTuvojY0ZSfgg2/vPF3GueR91nJDMwxH5nAX6etvEu9Q/JNn57BHrsumpCOb9lZyhfJOzCA==
X-Received: by 2002:a17:902:d70f:: with SMTP id w15mr91372159ply.134.1555527263380;
        Wed, 17 Apr 2019 11:54:23 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id w189sm109458529pfw.147.2019.04.17.11.54.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 11:54:22 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Markus Mayer <code@mmayer.net>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] memory: brcmstb: dpfe: prepare for API-dependent sysfs attributes
Date:   Wed, 17 Apr 2019 11:54:21 -0700
Message-Id: <20190417185421.1261-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190402230103.25491-6-code@mmayer.net>
References: <20190402230103.25491-1-code@mmayer.net> <20190402230103.25491-6-code@mmayer.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  2 Apr 2019 16:01:02 -0700, Markus Mayer <code@mmayer.net> wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> Prepare the driver so that sysfs attributes can differ based on the API
> version.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---

Applied to drivers/next, thanks!
--
Florian
