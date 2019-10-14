Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19478ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 10:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE62420854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 10:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIR2++nx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731689AbfJNKtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 06:49:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34686 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731235AbfJNKtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 06:49:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id b128so10206753pfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 03:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G8gq+lqSm5yWW7F43kBEhlO9mPcNo/sio34AqrTnoDs=;
        b=CIR2++nx6vd8Bz16k75idHqdvJPPUggJHKxR0wLUTH39CO7V5PzsdoM/D4Cl+k7hyo
         Gw7UFJe+mT5+cXWe9dIZ72glFDdSIFAbDa+G1XpiS+HtlwHLCMDZjNMrkE/g9VPFFBp+
         R3mcqDEhevL++epc29HvSaFesu8qAIF86+zutNohVYL+deOc2iccMu4XOocxhlbYeCVN
         7sMr5J6c50ESBVVdbsDa/VHCZzLy+oa8WGngXomAn3NyGRHltavsgM3JaDRkSnL6diQX
         YpOHyVJ5xETzTd3DzAft0NjYBLENis2h6cIfRDAawqTlsEABmHhWWpnfazaEWWQqyX/T
         fKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G8gq+lqSm5yWW7F43kBEhlO9mPcNo/sio34AqrTnoDs=;
        b=uRPJtsS/ESOtKecPLZRjfrdmgHWMctvxyA2Dft2KJtcau0NpF2k5RFaj4fxexA5JrU
         8XfPEzjw+yzwLIMMkqzkDeOxwZJAg08mpXIAXJC/MQjlw2gLmUkEOIFzT5CHSGqMaLxi
         RJFgfkf3mqXfta9WkV85meU75sjn4ZAjlOf4kOABDMl8PhOrbcrqdgpC7UHvau/NHwxK
         aZoT0BG6hB84XjZ8RuYmubheIJGDTQV74BWGlwONXJSuv4OLZ0Wcq7F6OjjrfZcot7E4
         LdkvzT8FBKEWWGF8HzX7x6rO2CmuIu8jRwOmmvffBQ3oJ3o8yp5DHgvrr1i29kew4DFq
         CJTA==
X-Gm-Message-State: APjAAAVWtO0eZgTmYK1tzYv5ogEUhh+gx3OMUJ3nHlXJWDMJNwcv3kNg
        zIX3glu29a7wz/ZBCyV5IYU=
X-Google-Smtp-Source: APXvYqxK+ACvb4vfK9cMbR0YJ3hmK6bo06YPieT5XWqEJ3eDQ98ONnljFCgnR5I1vhonY95PgbLgOA==
X-Received: by 2002:a17:90a:8002:: with SMTP id b2mr715256pjn.39.1571050172348;
        Mon, 14 Oct 2019 03:49:32 -0700 (PDT)
Received: from localhost ([211.246.68.186])
        by smtp.gmail.com with ESMTPSA id m68sm18688281pfb.122.2019.10.14.03.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 03:49:31 -0700 (PDT)
Date:   Mon, 14 Oct 2019 19:47:17 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Vitaly Wool <vitalywool@gmail.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Streetman <ddstreet@ieee.org>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Henry Burns <henrywolfeburns@gmail.com>,
        Theodore Ts'o <tytso@thunk.org>
Subject: Re: [PATCH 3/3] zram: use common zpool interface
Message-ID: <20191014104717.GA43868@jagdpanzerIV>
References: <20191010230414.647c29f34665ca26103879c4@gmail.com>
 <20191010232030.af6444879413e76a780cd27e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010232030.af6444879413e76a780cd27e@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/10/19 23:20), Vitaly Wool wrote:
[..]
>  static const char *default_compressor = "lzo-rle";
>  
> +#define BACKEND_PAR_BUF_SIZE	32
> +static char backend_par_buf[BACKEND_PAR_BUF_SIZE];

We can have multiple zram devices (zram0 .. zramN), I guess it
would make sense not to force all devices to use one particular
allocator (e.g. see comp_algorithm_store()).

If the motivation for the patch set is that zsmalloc does not
perform equally well for various data access patterns, then the
same is true for any other allocator. Thus, I think, we need to
have a per-device 'allocator' knob.

	-ss
