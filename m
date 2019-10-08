Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49907C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 21:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1370C20679
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 21:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5rO/Dlj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731113AbfJHVHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 17:07:20 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43134 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730523AbfJHVHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 17:07:20 -0400
Received: by mail-pl1-f194.google.com with SMTP id f21so8995412plj.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 14:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=3OUODisVOD2eZGqSrDXRITR9cL9jsCAanTmMcFWhJrU=;
        b=P5rO/Dljz6qsI4BairQeeF9R/FvzoNkXANU/VCuEqWLNU7hhL2tM0QGLTAczyw9L1+
         RrCpoSwkocV3QZyCXfhki800QnYOe6JLbH5rebMsK+DY/XTiAmU1zP3DYem2jWfZjomd
         jwLCvWQfD4Uwuee2V70OpUsCf3JSy0vbl9fmywFr0nrcHeBPqL0dpoRlRUhU1yz4y5ap
         Om7ty9T0UTideRDCggYz/MfflfRZ1wLgrMCm5m/d5nfxGzXkHd3Z3wESuCC3XT0iRp75
         wE/0Jb4R0GlM4Uejv1cl/lBlP8AOSHGaXmLJpwRQDKeOhRNkdJ5cV6ZCyGRstaFS4B8R
         Zaeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=3OUODisVOD2eZGqSrDXRITR9cL9jsCAanTmMcFWhJrU=;
        b=SGICbcubB7FJP1cOSf9YAW937FLw4GqxR7hKEK0k+zqc85iwIGBLx1otkWjvxLFUI5
         ToCj6paV9ZYcy8nYhv8dwU+KAVhCYHI18fPVZhw0qNFgqnBIt/Ku/y/QFwNIbSOOOah0
         QYScs0m0kItWvVFrSNBONNTZ9iiVjmE0BC7XqNzOaxzlIk2Zk0Dj2pyTzYRInZQd+xrA
         T9nYNejWzZs6CqfBSiowgweRJAIaDUCxF4d6G4EqOF+lqwd7TxB4xYFRLEh1NXuuRdBD
         TG94i6HIdRKvsxpFsJZ7DrupBj1AwZ+OHKMiYYCHtb48xz0n8wAiBBm+0OsF2DaA/uLd
         CJPA==
X-Gm-Message-State: APjAAAX05RLZ8qPuR0xzMcvTWqloWEHn3FAUInNuUg1jgs6ksnq80CS9
        rBkxl4BZOt8yVGnwm+kupEo=
X-Google-Smtp-Source: APXvYqz5KUf9ceAW7Xdkwzt/D6lzCQ9Zntf56ZioUPjXb8quaboFTkWtQy/dqRHZEYMMPO9ZUVa7nw==
X-Received: by 2002:a17:902:36c:: with SMTP id 99mr36251113pld.69.1570568839342;
        Tue, 08 Oct 2019 14:07:19 -0700 (PDT)
Received: from iclxps ([155.98.131.7])
        by smtp.gmail.com with ESMTPSA id b3sm93467pjp.13.2019.10.08.14.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 14:07:18 -0700 (PDT)
Message-ID: <56c3808b29838ff37852e196184a7b995f5f1336.camel@gmail.com>
Subject: Re: [PATCH v2] mfd: intel-lpss: use devm_ioremap_uc for MMIO
From:   GMAIL <ztuowen@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        mika.westerberg@linux.intel.com, acelan.kao@canonical.com,
        bhelgaas@google.com, kai.heng.feng@canonical.com
Date:   Tue, 08 Oct 2019 15:07:16 -0600
In-Reply-To: <CAB=NE6V64g5WLMYFxkpC_wsnSbGG-5Nn9uFo1zpcqjP9NsRB+w@mail.gmail.com>
References: <20191007184231.13256-1-ztuowen@gmail.com>
         <20191008151628.GA16384@42.do-not-panic.com>
         <20191008161245.GU32742@smile.fi.intel.com>
         <CAB=NE6V64g5WLMYFxkpC_wsnSbGG-5Nn9uFo1zpcqjP9NsRB+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think that's a fair point. Sorry for not noticing it earlier.

> On Tue, Oct 8, 2019, 6:12 PM Andy Shevchenko <
> andriy.shevchenko@linux.intel.com> wrote:
> > Maybe we can even split this to two patches?

I assume splitting means one to add devm_ioremap_uc and one to use it
for intel-lpss-pci. 

Tuowen

