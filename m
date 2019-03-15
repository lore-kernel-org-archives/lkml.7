Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B13C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 01:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2CD42186A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 01:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iE6TOBaX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbfCOBUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 21:20:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40244 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbfCOBUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 21:20:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id y124so5066630pfy.7;
        Thu, 14 Mar 2019 18:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/o6EGOEXYK/A646G2m+NIiIqTgtUxZAQFxy/FHk3JcA=;
        b=iE6TOBaXLcEOhHT3g2Pnpnx+W4rvA7QMppauIihSEqQEgTOudKKZz1Cf7IGsxv3pa2
         vNQryMWj8V+ZWygFGrktsGv0VwpX86wC5q3vKbNYP8NsIKEGJvbzSB5IImgD0DuGUTWj
         xlofdAKws3i8uFPJUFjxGJvrEiryIMGRwurF6EScu8VPscUU6zZ/EADMyCfw8kNgxT/o
         EnJNoyf53N9ywZzwnfFafoeYQQabAoyxAihjWmewZ7Tcggv8Fg5V/11a7EkrMK/K1NcA
         Ma2TSx6ihdKks3sBYOamZaAIdzvLbyRBVgExsX0f6GaJrMMdMeKZkDnuIFW621CWnIRK
         +6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/o6EGOEXYK/A646G2m+NIiIqTgtUxZAQFxy/FHk3JcA=;
        b=F7BqOz+m5lJeqGsrrmpnwGw1S1G1p5MsZcBkU0UNIa0jS54EeDl/ue7ATvmMr748xQ
         mrW71vQlhbkdJmiJ7AGw90VZ64A6eiISZyYOgJpsJ54QFo/M4tFKQ6Q2qa8bev7s6FMR
         7EdEnNeeVwsdQwmNaTIrym4aguBUu1DdaoRE9ltFa9A3KGeuA1yh9lnRe8305Fwt11NI
         w4pcWlwpA/sYDXcP7i9BlFLhOkDIjKZTgiALTHxjhPPzOOo6eSjcjKk5orSj8HhPyiUp
         A3OVJNIVULvOF0rnNnJJT6rQ7YsItT7fjDMIpeAZSlCiQ8c5ut6rsGWi2tEgtIPaWBaZ
         Dzug==
X-Gm-Message-State: APjAAAXUY4dsOQ6P1bdqjtVB5dP0EkKfnGVXNqXbewqNuSTdI1DmfQiB
        j0tJC9CzTmgDAbB4D8Pl54A=
X-Google-Smtp-Source: APXvYqy+NZIE6FvO6laKg0ztpOyN4ZlH2C66tqOLRrNj/Vov0SuISAY0zUu6NnaNbKp1MVfS0LRp9Q==
X-Received: by 2002:a63:2b03:: with SMTP id r3mr819867pgr.1.1552612816442;
        Thu, 14 Mar 2019 18:20:16 -0700 (PDT)
Received: from localhost ([110.70.55.120])
        by smtp.gmail.com with ESMTPSA id f15sm539929pgd.74.2019.03.14.18.20.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 18:20:15 -0700 (PDT)
Date:   Fri, 15 Mar 2019 10:20:12 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] tcp: don't use __constant_cpu_to_be32
Message-ID: <20190315012012.GA748@jagdpanzerIV>
References: <20190314061514.19586-1-sergey.senozhatsky@gmail.com>
 <CANn89iJMFfh1Pkvk9LOn3FwgAfpVjwS7q5x_8Y9zo2rzpy7w9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iJMFfh1Pkvk9LOn3FwgAfpVjwS7q5x_8Y9zo2rzpy7w9g@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/14/19 05:42), Eric Dumazet wrote:
> > cpu_to_be32() is capable enough to detect __builtin_constant_p()
> > and to use an appropriate compile time ___constant_swahb32()
> > function.
> >
> > So we can use cpu_to_be32() instead of __constant_cpu_to_be32().
> 
> 
> I dunno, this is uapi, this might break user space for some funky compiler ?
> I do not even know if cpu_to_be32() _is_ uapi.

Hmm, excellent point.

Looking at

if_pppox.h:#define PTT_EOL		__cpu_to_be16(0x0000)
if_pppox.h:#define PTT_SRV_NAME	__cpu_to_be16(0x0101)
if_pppox.h:#define PTT_AC_NAME	__cpu_to_be16(0x0102)
if_pppox.h:#define PTT_HOST_UNIQ	__cpu_to_be16(0x0103)
if_pppox.h:#define PTT_AC_COOKIE	__cpu_to_be16(0x0104)
if_pppox.h:#define PTT_VENDOR 	__cpu_to_be16(0x0105)
if_pppox.h:#define PTT_RELAY_SID	__cpu_to_be16(0x0110)
if_pppox.h:#define PTT_SRV_ERR     __cpu_to_be16(0x0201)
if_pppox.h:#define PTT_SYS_ERR  	__cpu_to_be16(0x0202)
if_pppox.h:#define PTT_GEN_ERR  	__cpu_to_be16(0x0203)
if_tunnel.h:#define GRE_CSUM	__cpu_to_be16(0x8000)
if_tunnel.h:#define GRE_ROUTING	__cpu_to_be16(0x4000)
if_tunnel.h:#define GRE_KEY		__cpu_to_be16(0x2000)
if_tunnel.h:#define GRE_SEQ		__cpu_to_be16(0x1000)
if_tunnel.h:#define GRE_STRICT	__cpu_to_be16(0x0800)
if_tunnel.h:#define GRE_REC		__cpu_to_be16(0x0700)
if_tunnel.h:#define GRE_ACK		__cpu_to_be16(0x0080)
if_tunnel.h:#define GRE_FLAGS	__cpu_to_be16(0x0078)
if_tunnel.h:#define GRE_VERSION	__cpu_to_be16(0x0007)
if_tunnel.h:#define GRE_VERSION_0		__cpu_to_be16(0x0000)
if_tunnel.h:#define GRE_VERSION_1		__cpu_to_be16(0x0001)
if_tunnel.h:#define GRE_PROTO_PPP		__cpu_to_be16(0x880b)

You are right, probably would need __cpu_to_be32, which also does
the constant folding.

=-=-=-=-=

Subject: [PATCH] tcp: don't use __constant_cpu_to_be32

__cpu_to_be32() can detect __builtin_constant_p() at compile time.
So we can use __cpu_to_be32() instead of __constant_cpu_to_be32().

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 include/uapi/linux/tcp.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index 8bb6cc5f3235..cf9c246a59c8 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -70,16 +70,16 @@ union tcp_word_hdr {
 #define tcp_flag_word(tp) ( ((union tcp_word_hdr *)(tp))->words [3]) 
 
 enum { 
-	TCP_FLAG_CWR = __constant_cpu_to_be32(0x00800000),
-	TCP_FLAG_ECE = __constant_cpu_to_be32(0x00400000),
-	TCP_FLAG_URG = __constant_cpu_to_be32(0x00200000),
-	TCP_FLAG_ACK = __constant_cpu_to_be32(0x00100000),
-	TCP_FLAG_PSH = __constant_cpu_to_be32(0x00080000),
-	TCP_FLAG_RST = __constant_cpu_to_be32(0x00040000),
-	TCP_FLAG_SYN = __constant_cpu_to_be32(0x00020000),
-	TCP_FLAG_FIN = __constant_cpu_to_be32(0x00010000),
-	TCP_RESERVED_BITS = __constant_cpu_to_be32(0x0F000000),
-	TCP_DATA_OFFSET = __constant_cpu_to_be32(0xF0000000)
+	TCP_FLAG_CWR = __cpu_to_be32(0x00800000),
+	TCP_FLAG_ECE = __cpu_to_be32(0x00400000),
+	TCP_FLAG_URG = __cpu_to_be32(0x00200000),
+	TCP_FLAG_ACK = __cpu_to_be32(0x00100000),
+	TCP_FLAG_PSH = __cpu_to_be32(0x00080000),
+	TCP_FLAG_RST = __cpu_to_be32(0x00040000),
+	TCP_FLAG_SYN = __cpu_to_be32(0x00020000),
+	TCP_FLAG_FIN = __cpu_to_be32(0x00010000),
+	TCP_RESERVED_BITS = __cpu_to_be32(0x0F000000),
+	TCP_DATA_OFFSET = __cpu_to_be32(0xF0000000)
 }; 
 
 /*
-- 
2.21.0

