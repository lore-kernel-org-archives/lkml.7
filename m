Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29743C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFBEC2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q4OIqDJm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbfKOQyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 11:54:25 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40086 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbfKOQyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:54:25 -0500
Received: by mail-pf1-f193.google.com with SMTP id r4so6949058pfl.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 08:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Tfe/SUZhIn9t5RW6hAc14gZbeUFmLObBQaF6UQbTZwo=;
        b=q4OIqDJmrXPZlzbniTUVof5UgtlL4UkeLu/nfd/W9BVKjeNQHRdWKWoFm85AsYtvyu
         yT0NfVOPynRb8CZvJtTESeEG9NEgEyf42TjUYkPk2aAeLkYzi1f+M+n0OKEgneGiWGNn
         BW3wg6VXY87MyeQEuBAFKixg1H1guo6rjbncgK+V4Y//rHP8uEdgyIfPK4izDqprqRIM
         BFdkjLTZQJdGW7hIpmz5WolynwNhXTAU9JpyuLbveVDoXlUpVH9UJnqHE6GPOvU5ijhh
         u+s4gDploqxjh/mpL6ULL3Ib0TPL3kDRwhWMvH0H/7q6IuRazyPo28qjkWWVVwNPLZ4u
         fTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tfe/SUZhIn9t5RW6hAc14gZbeUFmLObBQaF6UQbTZwo=;
        b=iEKon0X9AEAvWyLz2J5ZgzH9GDPhHBobZFbJX90+/V6H5IKXHlHQ2AuqkNr/YYBHDL
         cHqKG/AJ0RdufCdW0YdnzK8Gu3eeOmz0GU/0R3BjPVq4Qzg8qaJV2HnIE6kUMr7bHSx7
         uoYiv0F90/sJldm/EfCRrDrI15bR7fsAlSVYsPz69Frfps5lknvkOameQeXhA+Xg1Seh
         u98i45lFQ7KDASMO2kuCqJoDhdk6k022znF7epg8fORb1uhjCcSEnPuPgSXkUNMYQG4S
         oD49/KTitREECqNA8C1Dg1ouxUyojzm31tNT9biqLWut2Yje1YG8FSc6/3pV+WCDP7q4
         Ov6Q==
X-Gm-Message-State: APjAAAUbD+ZVp8qc0Fo/L7mU/y6FuKFHYH5VkN5Zaz9xuusaHfKdMD6v
        fJxpfDtf7XxShXjbVh/lhkU=
X-Google-Smtp-Source: APXvYqzU6tL058dch+6nHyFzxt6YjOWDLuH8YPyaeAcVQZv0n24XWeXPpTQd7yBViYMjwXd4GPZN/w==
X-Received: by 2002:a63:4387:: with SMTP id q129mr13965823pga.428.1573836863340;
        Fri, 15 Nov 2019 08:54:23 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id t8sm9614573pji.11.2019.11.15.08.54.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2019 08:54:22 -0800 (PST)
Subject: Re: [PATCH v11 1/2] fork: extend clone3() to support setting a PID
To:     Adrian Reber <areber@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Andrei Vagin <avagin@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
References: <20191115123621.142252-1-areber@redhat.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <fada5995-7fcc-7ca8-0933-4d0f52deef6e@gmail.com>
Date:   Fri, 15 Nov 2019 16:54:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191115123621.142252-1-areber@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/19 12:36 PM, Adrian Reber wrote:
[..]
> Signed-off-by: Adrian Reber <areber@redhat.com>
> Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>

Reviewed-by: Dmitry Safonov <0x7f454c46@gmail.com>

[though, I have 2 minor nits below]

[..]
> + * @set_tid:      Pointer to an array of type *pid_t. The size
> + *                of the array is defined using @set_tid_size.
> + *                This array is used select PIDs/TIDs for newly

/is used select/is used to select/s


[..]
> +	size_t set_tid_size;
> +	__aligned_u64 set_tid_size;

[..]
> +		.set_tid_size	= args.set_tid_size,

Is sizeof(size_t) == 32 on native 32-bit platforms?
Maybe `args.set_tid_size` should be checked?

Thanks,
          Dmitry
