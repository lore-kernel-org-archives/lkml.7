Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDBFC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 04:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82BF120730
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 04:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asSVrFaS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfLaEIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 23:08:17 -0500
Received: from mail-pj1-f47.google.com ([209.85.216.47]:37857 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfLaEIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 23:08:17 -0500
Received: by mail-pj1-f47.google.com with SMTP id m13so710488pjb.2;
        Mon, 30 Dec 2019 20:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=gmHUJOLLaB9uQbD8xdSCvMaI/BTVpj9YMHVwUXulGHY=;
        b=asSVrFaSM3ptGq2G1MOscGcpUb01d26yJ1MzLhamktRoZQ8FiIByFbu4HdTPDnyuwS
         1fTRng1wvRzkpGYrqENuhUmdXDUqWJidl8EKK462/b3EMgBvoRCpt3VLzzBU2cZgEms8
         JRUNiERTzLQltnJJCAy1PRQSqI766WvO0gQ/PqEO7mwVPx4Kl7aQHjoSvRVYGdymAYT/
         YyKtW9wrzRD6+lnuz8n40iyHhjofP0RamyjZQrwTJMLDozxGLKomLvugc5EU1ZUYAHri
         K9kKSeiBOL6CFFkrMlmllIle4HgXUTJU682iRuwtttYH98Hl0w06kNpB10iIX19/TFei
         jGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gmHUJOLLaB9uQbD8xdSCvMaI/BTVpj9YMHVwUXulGHY=;
        b=TJeTzsxF9YzF9Tu3Vw0FhRBNbPf4Ot7XPdwJ2WuGvLP3Z6bOPjFls6uE32KicRMUcl
         0LE+8R6gjhbrHx9tlHaO+7BXfxuIjXMRKMIS2X8nuwBJsGbzch/3M13yftewq0kxG+TY
         /Me5fxsyg4Y7Z0rQhqLqdvjfqovUu6BXwdZTIvkBg3RUvUS/KF0yO4W4LiCBEkbMd+Pm
         FSor9TG1sqwQPeLZOmnQwryotvx3DpDtxe3lhjaz4YcHEAEnOUcVBfc1R1tP7RXqgYPf
         wUFkdl9YNbRfAg4mnpisI6ANuJKS3YSsP9xtb/YZR3MxGaG4TVusOj9A8E2wW6igSbSA
         8giw==
X-Gm-Message-State: APjAAAVIy8CRUDRHsaW7LCJk87zLTsh60++tEKOUrQRpjsJ422iy6h7V
        ISbJcHDcrkqEokYGQuXLGio=
X-Google-Smtp-Source: APXvYqwsLEkZt9ztYkbDCkRzSfI9MOyqrR4KZI+qAEuOfLBSooRKkbzRvuewk5oCTkPh9BXzgrJ7tg==
X-Received: by 2002:a17:902:728b:: with SMTP id d11mr59344353pll.49.1577765296478;
        Mon, 30 Dec 2019 20:08:16 -0800 (PST)
Received: from ?IPv6:2804:14d:72b1:8920:da15:c0bd:33c1:e2ad? ([2804:14d:72b1:8920:da15:c0bd:33c1:e2ad])
        by smtp.gmail.com with ESMTPSA id c184sm54318701pfa.39.2019.12.30.20.08.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2019 20:08:15 -0800 (PST)
Subject: Re: [PATCH v2 2/8] Documentation: nfsroot.txt: convert to ReST
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     mchehab+samsung@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <cover.1577681164.git.dwlsalmeida@gmail.com>
 <92be5a49b967ce35a305fc5ccfb3efea3f61a19a.1577681164.git.dwlsalmeida@gmail.com>
 <20191230121807.3a1f5f38@lwn.net>
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Message-ID: <47e2ea6e-a808-5012-6f9a-8800fbd3be00@gmail.com>
Date:   Tue, 31 Dec 2019 01:08:11 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191230121807.3a1f5f38@lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon, thanks for the review.


Would you please rephrase this? My first language isn't English and I am 
not sure I understood that.

> It's best in general to avoid refilling paragraphs so as to make it clear
> what is being changed.  But we would also like to avoid creating such long
> lines.  Perhaps an add-on patch refilling things would satisfy both
> criteria here.



