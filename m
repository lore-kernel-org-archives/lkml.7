Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FBFC00523
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 00:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 334F222B48
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 00:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UDM5tSa2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgADAO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 19:14:27 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:35252 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgADAO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 19:14:26 -0500
Received: by mail-il1-f196.google.com with SMTP id g12so38020700ild.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 16:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=R48uDfvbHyWTipqs7DRRDZx/t6Cd7u9wYe+VP7psllY=;
        b=UDM5tSa2tnGzvESZ2RN3TFiI5Ix5FJeXQRnF+uwk7iTgykQhN7Rgwin17Zc/oaSzoB
         thdbqvGXfqNLNFALqDTAn5PaElyVR1Qu0+2jNR98NvFfLrT7Zkiq6s8tVrPozbf1KNV5
         FO5Fw3f6YI4widGm9hdbjnjD4/tRZJcCkhPEUaxH4IBeKD5FrUSTf26BV2nAq+L3T+yr
         XtsrwjwsE02M2gxb8rQMnY6xtD09FTIpNYVKpUrflzhmSYKMZ34Y/lOPxqnkurCXYVwR
         4ioz2seN/aTtCKunNmrjOauHQVq55LrZLu13K0Z3rHOXBHQAn8lXMfVApnGK+OUH+NQI
         r/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=R48uDfvbHyWTipqs7DRRDZx/t6Cd7u9wYe+VP7psllY=;
        b=mvIYi+E3v0XCK1b4phTPdHlbr49zOFH6tgnI7GfHnqEC2Z8OXTzr5TdZkC27HP/jtY
         ZBVC3ZxHVRvqNa8/fnQR9GmZ+KJEUPflFdSVWUE5AVp8JwhFjp3rqgX6oL+fUdIxkXBk
         NX4P6Pi8n6zDZbSYguHok6G402moc0dGEgANdTVq32qEueG0CCqmpmEKCFS7KRi8gxrj
         e8HHpjQhCzUC/mPE2ZetDCAeHML7kzjI9gSml94FYIzBLTZzy2yOfX1EwS0XFRE8ooxy
         3q36WCNOViHFFDnctnyd0ZsAuvshUsLOt2TJ4Df999KqlRiBLj3dEWC+iNWNV2/Y6upO
         Dsfg==
X-Gm-Message-State: APjAAAXwZslZeJLB37wasmrg/eVuwV4w9sii5lCOQuijHdPCtL6its3E
        vJ9hnomf96/1vYEnEeo5LXE0mA==
X-Google-Smtp-Source: APXvYqwqrs2TU2jOqKw7RWdj30czb3BigPHpXVIQJGRDMYgYcLrbY5G7Hc6HGd9UN5MF5KoduUtipA==
X-Received: by 2002:a92:d610:: with SMTP id w16mr74576853ilm.283.1578096866172;
        Fri, 03 Jan 2020 16:14:26 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id s10sm15117668ioc.4.2020.01.03.16.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 16:14:25 -0800 (PST)
Date:   Fri, 3 Jan 2020 16:14:23 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Zong Li <zong.li@sifive.com>
cc:     palmer@dabbelt.com, rostedt@goodmis.org, anup@brainfault.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/2] riscv: ftrace: correct the condition logic in function
 graph tracer
In-Reply-To: <20191223084614.67126-2-zong.li@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.2001031613340.283180@viisi.sifive.com>
References: <20191223084614.67126-1-zong.li@sifive.com> <20191223084614.67126-2-zong.li@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Dec 2019, Zong Li wrote:

> The condition should be logical NOT to assign the hook address to parent
> address. Because the return value 0 of function_graph_enter upon
> success.
> 
> Fixes: e949b6db51dc (riscv/function_graph: Simplify with function_graph_enter())
> 

There shouldn't be a blank line here - I've removed it in the queued 
version.

> Signed-off-by: Zong Li <zong.li@sifive.com>

Thanks, queued for v5.5-rc.


- Paul
