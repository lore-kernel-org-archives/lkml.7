Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453A3C00523
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 00:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C3C222C3
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 00:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="NYQdIoD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgADALE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 19:11:04 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:44501 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbgADALD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 19:11:03 -0500
Received: by mail-il1-f196.google.com with SMTP id z12so1522035iln.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 16:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=WiEa+o5Q5CybKGQcapfVdUUfq/OQ4KhWfLGnp+c9m/M=;
        b=NYQdIoD3So2vtdo/HpEDg5r/5v7qJvQ2o+0tZ8R6KXN9CkQqgQwbrb5S+Qx8pUSVDu
         VhieqxPsHSMQ9wqLQ7ZxkmbZ/MUqFt+Zka2kpF0mqHiK2PUHJGnLFtVE9yLKyJRRZmZy
         e98QwCZ6YrDmhDifh++T4wt7J7IY1BChfOsmI1p3Ws+7g9NrPcjmjGAADmuyEezAID+9
         UsFZjCNXekajuOskc5PBmVjImJOLKZhqxfnQGuzxFr8mu3wyVyo4s7Vj54qTDiiEm6ZO
         aB/INtigKBdCSZ8LXIbZ7vIEUu9bjxQx1n47JeDIUn6rRQLKujMy8ajc5Ak/sWLoEakr
         Pzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=WiEa+o5Q5CybKGQcapfVdUUfq/OQ4KhWfLGnp+c9m/M=;
        b=VJFCEWJZmUx71n34OAa7bU/fRtcFTE4F//+FfhHFPEQpQ0+B3G30fKTJNStq2/NTez
         z5Kvq198AKKFoYTt1tAcHJmiC4qoWwyMwjURkNP4X5zCCJ+cy7dwM8shybXKiMCtK+Wk
         wrP3EHPYv0oQNPrnzC8APEc5qyq8ayKTBzVKNpdnpiMNgWTUz8ySPvazzSfmumWep/Fs
         9Wq+WBHLZUDqL7/wXVSBlrMOo14t8vTyZs2pu9/XTHcAwUFALUfHnzS9mA1xIcY5DIyI
         N4VS+g2IkaTVYaxW1zV6kPUc2mu5yPLb88Wa8MUihqc6ihIAdLkKunJWd6iBn6wDST67
         Og9Q==
X-Gm-Message-State: APjAAAXCIhQo3Pk5vPXk8jff+w6w8yoaJV4ejvF0kR5smY9HO1JU/hDw
        0MtVjBRhcRSlsUtEwVDvEryAFw==
X-Google-Smtp-Source: APXvYqztMA0ImuOwI4vnJlP3KqgCNhVBA+tcEjzNHZNfEO+6ejnXkFxewXTPNXnddnnAha0yRPvIdw==
X-Received: by 2002:a92:160a:: with SMTP id r10mr73359367ill.14.1578096663169;
        Fri, 03 Jan 2020 16:11:03 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id f7sm15152328ioo.27.2020.01.03.16.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 16:11:02 -0800 (PST)
Date:   Fri, 3 Jan 2020 16:11:00 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Zong Li <zong.li@sifive.com>
cc:     palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] riscv: mm: use __pa_symbol for kernel symbols
In-Reply-To: <20200102031240.44484-3-zong.li@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.2001031610470.283180@viisi.sifive.com>
References: <20200102031240.44484-1-zong.li@sifive.com> <20200102031240.44484-3-zong.li@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jan 2020, Zong Li wrote:

> __pa_symbol is the marcro that should be used for kernel symbols. It is
> also a pre-requisite for DEBUG_VIRTUAL which will do bounds checking.
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>

Thanks, queued for v5.5-rc.


- Paul
