Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB5BC282CE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 23:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8933A2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 23:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Yq7rl/Ks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfDLXpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 19:45:14 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37375 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfDLXpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 19:45:14 -0400
Received: by mail-qt1-f194.google.com with SMTP id z16so13251089qtn.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 16:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=gMsKQF+1fBuG9KQIpk6GXNpTDQgZWxP6lz1tunnwBlA=;
        b=Yq7rl/KsFb5DY2T5MNQI8x61ibtypVu8I2B3xFQVnor+LCzBINHFvcq8qVOlQDG2Ax
         OU0KWndeLyGzk6fB+KuCpn08xidgOpRwZt/Whkpc84o+jHaFgozCk1x9TCILUuktUUL2
         IcAjtzvTvu4vgmuc1iPI15fQXodyfCPQBp0FGOCs4ICYeR9EMIw2vf5gAM+LT5fd0LPi
         ftjPmv42PkZ3RN8quHeeuWiByZ6j3XM7NW09gYii07EZRpJkRf//d/9g+yvn6jw/Kr7H
         pGRyBPsS9nkLs4wyvrLT39m9XXDXFalNnXqMw28jEsC7u1WHFo+4ByaMBJIIMpujEQ/M
         Pgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=gMsKQF+1fBuG9KQIpk6GXNpTDQgZWxP6lz1tunnwBlA=;
        b=diKNBn4FgRTP9+OznKYA8BeR3KFNyem37PAXu8E1x6SrSAm8ITx4Z+BBS4kxnnSiJF
         6rz69Z/i09fIKUOhQdph+XoHirp3SxoJWKkovcIKDzazf0AStDgycKiYrNZ2YhGCgPOC
         7VHXB/5Qrcf8yNOTSCl0jqhSwi0ftOPSUxQxVWr3uim6cg0PBOjiiyThd+wLzJnzjnEq
         OTRCE9UIsOWXET3a7K3Z2AAWrU1qG7c4zPeaEVPI3w8Z5A0Pu0++HYJoZPfpYbB7r8hs
         yl7Bb185UZ3POjlOUcpSbxcL8FRTA7eyonAXVVtYU5YavYWWU8LxDM1B4d8Nh3Jn1QJJ
         sh6w==
X-Gm-Message-State: APjAAAWi+UT6xJA3XP6HZK8B+d35w8CL/l9Gq9QsX2FISBh7E1J+3Q5U
        q3NPbAdORZVcgpmfTgVK/SYSAdGBUAc=
X-Google-Smtp-Source: APXvYqzYX7gzkCt4QrIxsqKzr5SSEWhOhHaTofBKl5KacKMknTsMMLBpVbn4w8zOWhs583jcV0TJAw==
X-Received: by 2002:a0c:b8a8:: with SMTP id y40mr48972264qvf.27.1555112713474;
        Fri, 12 Apr 2019 16:45:13 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id t35sm29133218qtc.10.2019.04.12.16.45.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 16:45:13 -0700 (PDT)
Date:   Fri, 12 Apr 2019 16:45:08 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Alban Crequy <alban.crequy@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alban@kinvolk.io, iago@kinvolk.io
Subject: Re: [PATCH bpf v2] tools: bpftool: fix infinite loop in map create
Message-ID: <20190412164508.0f5ed5b3@cakuba.netronome.com>
In-Reply-To: <20190412124050.32120-1-alban@kinvolk.io>
References: <20190412124050.32120-1-alban@kinvolk.io>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Apr 2019 14:40:50 +0200, Alban Crequy wrote:
> From: Alban Crequy <alban@kinvolk.io>
> 
> "bpftool map create" has an infinite loop on "while (argc)". The error
> case is missing.
> 
> Symptoms: when forgetting to type the keyword 'type' in front of 'hash':
> $ sudo bpftool map create /sys/fs/bpf/dir/foobar hash key 8 value 8 entries 128
> (infinite loop, taking all the CPU)
> ^C
> 
> After the patch:
> $ sudo bpftool map create /sys/fs/bpf/dir/foobar hash key 8 value 8 entries 128
> Error: unknown arg hash
> 
> Fixes: 0b592b5a01be ("tools: bpftool: add map create command")
> Signed-off-by: Alban Crequy <alban@kinvolk.io>

Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
