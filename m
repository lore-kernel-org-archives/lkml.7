Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9ABC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF5320726
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="B4Jzw/Ai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfLIOyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:54:08 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44670 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfLIOyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:54:08 -0500
Received: by mail-lf1-f67.google.com with SMTP id v201so10901350lfa.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 06:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zXCvNPBFfW6TtfKXO5Yk7VgQZcEUj3Or8FZH8YnZ5iY=;
        b=B4Jzw/Aiu3fSn3JF/ZLYnhir6fFzn6dD+MZZbz9Pe3E6F+8fFxwMniLnAcpy4ujmNe
         ePgzHV0FFAKuT8AKRgx4vVXFtvLNOx0HkZmnG3GYtiW6EwfAcOoL6MaaNbAr4RtP6Z62
         +xJBFUSCmYf6Ib5ZTNn6KkIdK5xtigBddx58s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zXCvNPBFfW6TtfKXO5Yk7VgQZcEUj3Or8FZH8YnZ5iY=;
        b=WlstWxjLYDye78h4vIxT3r9yA1Nf6HErmZ/bpZR705CXn2B9XD+3d76X7KZXzh/oJl
         IU6smb7oaROl/DKZ+EAM6Xof1V1xKe3ifoYfkM3hEwRTPeMY4sEQBhon5H9eR5nHO0ci
         l11X6Nw7R+mG+jp4U+n1p32fXRd+bFFeZLjVuYGMi9fDOpWaASdd0J4pz7EGBAWQCRSH
         dGHHAM9tBLRgVqDMCDwnJQC6/6VdMkeQNwZOiNL+AFxvoKKDr0CICSQODZG0FR76DMax
         7qVRkTyEYk7Y63AXwoUycBbMtgXpEyOAApsAuPIrMoGU/KX4fTcVoVGKZ0y0uFk/FZLh
         BCkA==
X-Gm-Message-State: APjAAAXz8+ieJQBIQmtt5YiDgscArv3YWIBc0waH1CxEkBY3UDzJrj5Z
        bc6UzNBhUeJDXuXHZ0hCLLWfSJz6rpXha9iL
X-Google-Smtp-Source: APXvYqySt6anXUyT6kvrIZam/0bhlCpHB2LLS+I8Pe3IeqDuhU00X2/Hkn5xzYQqfHogs7Pf2XjfgA==
X-Received: by 2002:a19:f00d:: with SMTP id p13mr16200102lfc.37.1575903246184;
        Mon, 09 Dec 2019 06:54:06 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id w16sm11170372lfc.1.2019.12.09.06.54.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 06:54:05 -0800 (PST)
Subject: Re: [PATCH] fs/namei.c: micro-optimize acl_permission_check
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191113214521.20931-1-linux@rasmusvillemoes.dk>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <8385b895-0269-236a-665b-244a386167ac@rasmusvillemoes.dk>
Date:   Mon, 9 Dec 2019 15:54:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113214521.20931-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping

On 13/11/2019 22.45, Rasmus Villemoes wrote:
> System-installed files are usually 0755 or 0644, so in most cases, we
> can avoid the binary search and the cost of pulling the cred->groups
> array and in_group_p() .text into the cpu cache.
