Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAACBC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 954E821900
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsajtgcF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfCPO0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 10:26:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38182 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfCPO0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 10:26:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id n125so8297112pfn.5;
        Sat, 16 Mar 2019 07:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KEOD+8UtXijC+wP4hR1bvlZBLv6r5WmiqskVo3P9LGA=;
        b=DsajtgcFqZbs79z0c2qsZBmHcz8kj+3hCAa3BHD/yxx2vtqAJtG36VC9nEORM7yQ/s
         aVvA5poO82aRNuH9hgwqLhighBJKJ+z927cePbEu7/XoLKAhgQzSM6ruY2Gh97C2bGqw
         Dt0XgcL3ZUcNFhaR4yakbMjZC4a6wTyQFtRe0qKQ71Q/mvKnqWfQzGZL6JymkGBelzLk
         U5zE5CRxV8LywFO0Wf15kosWsalCOdOiebYuJAd9u7VeweBpDrM94kFMqXhN7+xfT2w4
         0y5pGhDMd+0OtsI8+cZ36DJ7V+hV5ZgRen+7xuUMA7/Zhwu+eqC3Apk+f/cIi+i4pVi/
         homA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KEOD+8UtXijC+wP4hR1bvlZBLv6r5WmiqskVo3P9LGA=;
        b=GcDrb6+6b4QDMFxlGS/I1hfQ+voze66K5B1FhxkCIjN3KOK2fwicok9lKSx3BR+y+U
         Pu1sfaLFzCBJYDaDdLYb5T7U7EHhOaY4BUQqA5yqwWvX+4kHbPYt05YYZUDXvNPuoNrj
         x9dam5iwbtIY6+uiFeGt6TxvVJGU1LhobwckOs+sa/f9WIfnL95nmbjGFm/GeVWRuTsN
         fItzEwiJZRnZbWtw05LAeJL6I8J4dAv03VdpJU9bciFJP+h8VCb9gJht0B5BE4O2kqUj
         UF2NBYffXVtZpWL0dl4vrOq2T5JdW83NOn1Ujj4pLwMTgk/2lcJUJf8c9rzS+dupSOHJ
         tEXQ==
X-Gm-Message-State: APjAAAWBwEhKaiGM5mVN52wFoTwQou0WGBPrUHc9FjWVPyhUTnbt5rHE
        ZEKQdO+/2La3e5QqEP9RuYGpgg3D
X-Google-Smtp-Source: APXvYqyWghDPmi2cFUS5BvhGBftb+juekWFZBWoeYAJfsahfFwxtfny4LHkeumEQVGqRR9X8xqMwJg==
X-Received: by 2002:a63:cc03:: with SMTP id x3mr8712573pgf.121.1552746409750;
        Sat, 16 Mar 2019 07:26:49 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id v15sm10765132pfa.75.2019.03.16.07.26.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Mar 2019 07:26:48 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Sat, 16 Mar 2019 23:26:46 +0900
To:     Stanislav Fomichev <sdf@fomichev.me>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] tcp: don't use __constant_cpu_to_be32
Message-ID: <20190316142646.GA10815@tigerII.localdomain>
References: <20190314061514.19586-1-sergey.senozhatsky@gmail.com>
 <CANn89iJMFfh1Pkvk9LOn3FwgAfpVjwS7q5x_8Y9zo2rzpy7w9g@mail.gmail.com>
 <20190315012012.GA748@jagdpanzerIV>
 <20190315172428.GB5481@mini-arch.hsd1.ca.comcast.net>
 <20190316051902.GA27630@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190316051902.GA27630@tigerII.localdomain>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/16/19 14:19), Sergey Senozhatsky wrote:
> # define __bpf_ntohs(x)                 __builtin_bswap16(x)
> # define __bpf_htons(x)                 __builtin_bswap16(x)
> 
> So I sort of suspect that what should have been done was that
> __HAVE_BUILTIN_BSWAP16__ ifdef, just like what include/uapi/linux/swab.h
> does.

E.g. use uapi __swab16/__swab32 in selftests/bpf/bpf_endian.h?

-=-=-=-=-=-

 tools/testing/selftests/bpf/bpf_endian.h | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_endian.h b/tools/testing/selftests/bpf/bpf_endian.h
index b25595ea4a78..68789b4c7ef0 100644
--- a/tools/testing/selftests/bpf/bpf_endian.h
+++ b/tools/testing/selftests/bpf/bpf_endian.h
@@ -20,38 +20,22 @@
  * use different targets.
  */
 #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
-# define __bpf_ntohs(x)			__builtin_bswap16(x)
-# define __bpf_htons(x)			__builtin_bswap16(x)
-# define __bpf_constant_ntohs(x)	___constant_swab16(x)
-# define __bpf_constant_htons(x)	___constant_swab16(x)
-# define __bpf_ntohl(x)			__builtin_bswap32(x)
-# define __bpf_htonl(x)			__builtin_bswap32(x)
-# define __bpf_constant_ntohl(x)	___constant_swab32(x)
-# define __bpf_constant_htonl(x)	___constant_swab32(x)
+# define __bpf_ntohs(x)			__swab16(x)
+# define __bpf_htons(x)			__swab16(x)
+# define __bpf_ntohl(x)			__swab32(x)
+# define __bpf_htonl(x)			__swab32(x)
 #elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 # define __bpf_ntohs(x)			(x)
 # define __bpf_htons(x)			(x)
-# define __bpf_constant_ntohs(x)	(x)
-# define __bpf_constant_htons(x)	(x)
 # define __bpf_ntohl(x)			(x)
 # define __bpf_htonl(x)			(x)
-# define __bpf_constant_ntohl(x)	(x)
-# define __bpf_constant_htonl(x)	(x)
 #else
 # error "Fix your compiler's __BYTE_ORDER__?!"
 #endif
 
-#define bpf_htons(x)				\
-	(__builtin_constant_p(x) ?		\
-	 __bpf_constant_htons(x) : __bpf_htons(x))
-#define bpf_ntohs(x)				\
-	(__builtin_constant_p(x) ?		\
-	 __bpf_constant_ntohs(x) : __bpf_ntohs(x))
-#define bpf_htonl(x)				\
-	(__builtin_constant_p(x) ?		\
-	 __bpf_constant_htonl(x) : __bpf_htonl(x))
-#define bpf_ntohl(x)				\
-	(__builtin_constant_p(x) ?		\
-	 __bpf_constant_ntohl(x) : __bpf_ntohl(x))
+#define bpf_htons(x)	__bpf_htons((x))
+#define bpf_ntohs(x)	__bpf_ntohs((x))
+#define bpf_htonl(x)	__bpf_htonl((x))
+#define bpf_ntohl(x)	__bpf_ntohl((x))
 
 #endif /* __BPF_ENDIAN__ */
