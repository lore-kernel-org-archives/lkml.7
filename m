Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336B2C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 15:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B84208C4
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 15:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578412275;
	bh=nJVYT/U5maLQNNtqfRJbbs2ienxBTq+nbdqM0hNFVIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s+sJtv8iPc6SBfLfBWsTu0/o/vN5qTygZ+3e00PVLQ3pVjhNysvgGvbtLMQ2B1neK
	 metE4kwEiohzpYQsES6AX+nCoC8ZhhAQmKcivzUiG6X9ZwgssYTLkDizlneIMQ+c0y
	 ysenFVdPPPwBJ0wEyYvqvCk36ghnqaVpKHVlvn+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgAGPvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 10:51:14 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41622 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbgAGPvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 10:51:13 -0500
Received: by mail-qk1-f194.google.com with SMTP id x129so43036265qke.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 07:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J6LXMJUE1RUraKI8sOLtnlOpChltycjVhd5XuyF/q5Q=;
        b=q/nQ+GgRjArznKrQtHLZOTr6ff4gY7w4rh2bntrSCShHJWzUz7Zt/1ZrZEQvJx3YdU
         Ig0XcK7tB8xrK36EyTyF1sXN7gJOuMu3PnrVKXefm0QYblHfxD2ilqIZPUCP0smQiXuK
         vc0l+6ceMUifn18DgjznmXga4M7kvbkeKKdoVJO2sBuh3M7SlVBoOLeY0tpB4MyrcQVh
         G9wiuM3TLe7Tl/pJiPVHB929ysBIOm4I7Oomun9NeblsZ5DnZOElKEKQxIieCw3vSELB
         TekpMYnzH7oNPR/JC9YqLPSf9Itt3HYjDrUtpm0oly+DongVRbt4fMe0bIyoTpELXKol
         vHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=J6LXMJUE1RUraKI8sOLtnlOpChltycjVhd5XuyF/q5Q=;
        b=tnR1EDx/+WGwFE7MFgexMqc05Oh/UZhfDvaz5oXfZeGc3vNuBg4EYSHZ+pVjFtkWtL
         fgBp2OckBD212uCpsmohHu3uOmxrWWxFYiJ43SJDm9eezPFJlUim397GWqLvuxPisYOM
         5PRCte4CXeoW21NF/C287eI5pSHj8rgEceoxjaGkEcu/wff4Dkef/l+bPIi4NyGc4JH1
         OTtjzz0oquMMzMq02b1P7NUVtMtCFXW4K75nQeHIdsUSate2w5hxoebzlsNzEL3JWHqS
         Zo7vaMXkGeThs4g9T8bRhTaLfv+TW0Y3RT/h0sgQRo/lr4VoV2fxPRErCt8YTU39V2XU
         16aQ==
X-Gm-Message-State: APjAAAWYg5bJAW7C7hdO0E5oKNYa1fWRKgTpBI0ixfj1ybBvLL6WaeRN
        O/rwCsfthNW4KhF+BWouPEQ=
X-Google-Smtp-Source: APXvYqwFE0yIBRKYNAbH5BaSDFqWPXNgDX0oOhgEwbZo4vju64h5GK9IXa8FPFiu98h4s7B2apBahg==
X-Received: by 2002:a05:620a:12d5:: with SMTP id e21mr88823093qkl.44.1578412272430;
        Tue, 07 Jan 2020 07:51:12 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:4305])
        by smtp.gmail.com with ESMTPSA id b81sm22507306qkc.135.2020.01.07.07.51.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jan 2020 07:51:11 -0800 (PST)
Date:   Tue, 7 Jan 2020 07:51:10 -0800
From:   Tejun Heo <tj@kernel.org>
To:     mateusznosek0@gmail.com
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH] fs/kernfs/dir.c: Clean code by removing always true
 condition
Message-ID: <20200107155110.GA2677547@devbig004.ftw2.facebook.com>
References: <20191230191628.21099-1-mateusznosek0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230191628.21099-1-mateusznosek0@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 08:16:28PM +0100, mateusznosek0@gmail.com wrote:
> From: Mateusz Nosek <mateusznosek0@gmail.com>
> 
> Previously there was an additional check if variable pos is not null.
> However, this check happens after entering while loop and only then,
> which can happen only if pos is not null.
> Therefore the additional check is redundant and can be removed.
> 
> Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Greg, can you please route this one?

Thanks.

-- 
tejun
