Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFC1FC6197
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D4A920869
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="BGsscPnI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387518AbfKHV06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 16:26:58 -0500
Received: from mail-qk1-f177.google.com ([209.85.222.177]:44837 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387395AbfKHV05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:26:57 -0500
Received: by mail-qk1-f177.google.com with SMTP id m16so6567843qki.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 13:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=E/re/TtVqjhhFyMNUDrEMQoMA+rNSBWgaDnjt6xblfc=;
        b=BGsscPnI0I/AhxQtkp1ur0VrFYXf5H8Fg7QmP8nllWAk3LB+1xRvuro/YNq+Wi4p5F
         3ZAD5u8+aHKV6BCRpJFppf3VuxZKf/sv7n021xyePsMo0qyk4ioIipKyJxsfny2R6RX3
         muOR0J1B2kxQSzV9581+eZYOESV3d8dZz1I/0lFZM3rKt3ovoGT+VSWRIahQ6OsN3IV1
         s8FtMLqcLzCVTjdBygGBm4m5G43Y6e3kQ7cTLWjekKCGP5ylAKVgqVGK8DUT21Ht4cN8
         7GXkMXTsKy8U08dIiAi7+G9AKRSNl22O/wb8ep0nz17TwjAIvaYLFkN2KBK6QMSY1A7d
         ming==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=E/re/TtVqjhhFyMNUDrEMQoMA+rNSBWgaDnjt6xblfc=;
        b=S/6tTGdmBHkEx0/Wfqpwnr3Yc5VfKRdwTdJ8dVItdOtlsEi/eLKHL4vAfdKmDqFd3z
         xJLUVKbN3dJSN8WhZBRJvgWW1FnndF2Zdqu/EjwuELCO+JaQM5Tko+n64dv0HOlujudz
         oMLR9/pS4fMrTaDYEuVqgyGAH7c9k3sVh9gHlNCicc+1tbms5/WDlwjjzbk47hiD3Q2X
         etIVRCPR0fyXpgDltoTjujpqg7/FnPlE9Ur+iNHmVGA6n4VZ73tdirir5jwoSaUFSbK/
         m2bWa1ypQwBwSek5A5kXkXHz4wNA173uNugAG3rpvjFaHDu8MFt6UfSXXGJ5M4LQzAOR
         2AzQ==
X-Gm-Message-State: APjAAAUdNYJJ22AxNLdlJcXBMWqJtX9fRK5SR1IPLOlBtPoWIAUncajd
        tORpL9pF4sSINz76TX9Ft/3N6AXW8H+MNw==
X-Google-Smtp-Source: APXvYqyLA9raRCjGEtQ5L5aO6bE7f5z5e7jdeJYvdN/uTfRWHR1m08qA/W6lvIBR0YH8Zrl54083xw==
X-Received: by 2002:a37:9d86:: with SMTP id g128mr11128288qke.191.1573248415230;
        Fri, 08 Nov 2019 13:26:55 -0800 (PST)
Received: from ?IPv6:2600:1000:b04c:9cbe:6d67:a89d:e323:d2c? ([2600:1000:b04c:9cbe:6d67:a89d:e323:d2c])
        by smtp.gmail.com with ESMTPSA id o2sm3375987qte.79.2019.11.08.13.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 13:26:54 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next] mm/vmscan: fix an undefined behavior for zone id
Date:   Fri, 8 Nov 2019 16:26:52 -0500
Message-Id: <64E60F6F-7582-427B-8DD5-EF97B1656F5A@lca.pw>
References: <20191108204407.1435-1-cai@lca.pw>
Cc:     mhocko@suse.com, hannes@cmpxchg.org, guro@fb.com,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191108204407.1435-1-cai@lca.pw>
To:     akpm@linux-foundation.org
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 8, 2019, at 3:44 PM, Qian Cai <cai@lca.pw> wrote:
> 
> -    for (zid = 0; zid <= zone_idx; zid++) {
> +    for (zid = 0; zid < zone_idx; zid++) {
>        struct zone *zone =

Oops, I think here needs to be,

for (zid = 0; zid <= zone_idx && zid < MAX_NR_ZONES; zid++) {

to deal with this MAX_NR_ZONES special case.
