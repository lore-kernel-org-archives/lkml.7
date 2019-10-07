Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D13CC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 08:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B572133F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 08:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="JIKEPFmb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfJGI4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 04:56:14 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44782 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfJGI4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 04:56:14 -0400
Received: by mail-lj1-f196.google.com with SMTP id m13so12680540ljj.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 01:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oF5jAujUKODNIkx3N+qAq7fK2yODGoDCZN8QrSoPvIM=;
        b=JIKEPFmbILhicqpj7J2lmB3IWsrAnubkX4o6AW64rIBaEUEmLXm79mYHxWTI1atpJR
         oL7BwtLnFsM1CS9ISo6frgzNJCQzkl0LNZJzgjwGUONXUSoZqRXJeLg8Wqv9BmkmA8dc
         drzoZIqwKPyOPOY5Zisqb/IgrqB/Xl0zIN2SE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oF5jAujUKODNIkx3N+qAq7fK2yODGoDCZN8QrSoPvIM=;
        b=Ns57a+dgJpQMzM5FkYkIaOCqHvmJ63RCOsZkv/3Oezc8IlIVlhm1/8Wcovn3Ri676v
         0oXM/n7ukSm1X04ryQu7Vxew8yrv1UqVWRGuSm7l3EW26zQ4GZuyefWJQRoQAB4uZkQj
         fENt25Nx6nx6yOllLc+yXtAVXNhvpYXZOf314o/s1WAbaCkfeHp7r4JIBSSYAX/wX4LO
         2TZVs09LlItteX9ePgVcD7+ROB9EEtDcu/argxttj91FM7R1S4HSmMX/u389SGWLWD+C
         YrQl1SrmfxxUQOoGYrbFYWw9k82heNKSDcnABzdjqf7dFIl/sgansYR2mVAcuutaj0ty
         1mlA==
X-Gm-Message-State: APjAAAVdXdqlX4+7NI+9Z+5C3YryUWJderdBXrleR3gxIqXpiEJoxK9e
        XOhRqcB/i27glyaaRZ6HulFAeyMzDhSllaWc
X-Google-Smtp-Source: APXvYqw4fomsIbsbkk4SCc9kr0O8RtR67DLMPm/N2rsTXQoPA6HfBEAykGUIKkY3ps34BWRcs929fA==
X-Received: by 2002:a2e:7502:: with SMTP id q2mr17826943ljc.202.1570438571690;
        Mon, 07 Oct 2019 01:56:11 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id f6sm2665455lfl.78.2019.10.07.01.56.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 01:56:11 -0700 (PDT)
Subject: Re: [PATCH 1/2] x86: mmu.h: move mm_context_t::lock member inside
 CONFIG_MODIFY_LDT_SYSCALL
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20190828193836.16791-1-linux@rasmusvillemoes.dk>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <29e830f8-65fe-c2b9-1c3f-4359bdf8ac64@rasmusvillemoes.dk>
Date:   Mon, 7 Oct 2019 10:56:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828193836.16791-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2019 21.38, Rasmus Villemoes wrote:
> The placement of the lock member in mm_context_t suggests that it is
> used to protect the vdso* members, but AFAICT, it is only ever used
> under #ifdef CONFIG_MODIFY_LDT_SYSCALL. So guarding the member by the
> same config option is a cheap way to reduce sizeof(mm_struct) by 32
> bytes (only for !CONFIG_MODIFY_LDT_SYSCALL kernels, of course).

Ping
