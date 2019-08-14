Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527B0C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208A82083B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pwWgDLh7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfHNL5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 07:57:09 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35385 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfHNL5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 07:57:07 -0400
Received: by mail-lf1-f67.google.com with SMTP id p197so79077244lfa.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 04:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NQRv3f2EYUb06woT418BGqq97YNnVB8OYMpYY5o3G2Q=;
        b=pwWgDLh7iYR6sRQOCJzxTO6tecq64oUlC4c7f/4xtIwFCLccjuOyP6JyD4AXKJRbah
         JcDr1MWsPgGKFggJi6QbkZebYKci1OeAu222Yb7wkJpAquU0crFSRVMMp3sU4JsdHO4+
         /uw0uBcRqK0pyKcfeE9mNM0bNYHDEkUC1dAQogzrPVk4VEdd700ntVYFugzInlldgdUy
         ATO6ZXEjSPyOVaL8Cl9bTbTgoCOkAJhCLZPtdfyfC5Ce5tgJ5jif3BbCwF8cL4X/l1/s
         JJ10aC9rgIeo6W+EHzWqPw7sziL3TvnVyLwRRt4/YfkF0NO0DthScobM+NzYy1feiiKr
         /NFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NQRv3f2EYUb06woT418BGqq97YNnVB8OYMpYY5o3G2Q=;
        b=DhWbVAVLsnxAiCRZ9AYx0odERcC8ZM5lff0H+vCpe/9dO6XRqMEejUAPODbebzNwAH
         80fNZ2XrtNHQowpJsU4o7BnyWdaYxn7xmyqbHmjMH2RX3VdJjLyeYe3R6xd02iwAyHd0
         VC2/DMI9uKuMwxSdjqRf8m5KZ2x801EzxnoaMyFlcuedTOIH+IsgCkqc/cug+A2UiDO+
         zCQgWknHNWb48J2+ZaZN+IHv7gVHSMFThzHY0kHbGu63QGsAApLrtOYqbciPJd4dTXEG
         YIOMwAAhT9GdhNqug+iKI9eACZ6EsfJ4zHpfY2dLwz54465x3rgQ/SL8ueXILxDRUCLi
         M/6g==
X-Gm-Message-State: APjAAAVh3XpDnKR+PD1wYRcOWxAyZZwVgyPDZdCOaJKPA0wTrINBff0y
        hpMVLfiA7F8xu+SUx4tiKFIRAg==
X-Google-Smtp-Source: APXvYqzOgzOY6LTmx3JBaNbysMTHtK15OczaIj3bzLiDDXl4ewJmN6E8TYxWy9IdQIK3Tey6xtwMIw==
X-Received: by 2002:ac2:55a3:: with SMTP id y3mr26236068lfg.101.1565783824241;
        Wed, 14 Aug 2019 04:57:04 -0700 (PDT)
Received: from khorivan (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id t25sm20124603lfg.7.2019.08.14.04.57.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Aug 2019 04:57:03 -0700 (PDT)
Date:   Wed, 14 Aug 2019 14:57:01 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        xdp-newbies@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/3] libbpf: add asm/unistd.h to xsk to get
 __NR_mmap2
Message-ID: <20190814115659.GC4142@khorivan>
Mail-Followup-To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        xdp-newbies@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
References: <20190813102318.5521-1-ivan.khoronzhuk@linaro.org>
 <20190813102318.5521-2-ivan.khoronzhuk@linaro.org>
 <CAEf4BzZ2y_DmTXkVqFh6Hdcquo6UvntvCygw5h5WwrWYXRRg_g@mail.gmail.com>
 <20190814092403.GA4142@khorivan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190814092403.GA4142@khorivan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 12:24:05PM +0300, Ivan Khoronzhuk wrote:
>On Tue, Aug 13, 2019 at 04:38:13PM -0700, Andrii Nakryiko wrote:
>
>Hi, Andrii
>
>>On Tue, Aug 13, 2019 at 3:24 AM Ivan Khoronzhuk
>><ivan.khoronzhuk@linaro.org> wrote:
>>>
>>>That's needed to get __NR_mmap2 when mmap2 syscall is used.
>>>
>>>Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>>>---
>>> tools/lib/bpf/xsk.c | 1 +
>>> 1 file changed, 1 insertion(+)
>>>
>>>diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
>>>index 5007b5d4fd2c..f2fc40f9804c 100644
>>>--- a/tools/lib/bpf/xsk.c
>>>+++ b/tools/lib/bpf/xsk.c
>>>@@ -12,6 +12,7 @@
>>> #include <stdlib.h>
>>> #include <string.h>
>>> #include <unistd.h>
>>>+#include <asm/unistd.h>
>>
>>asm/unistd.h is not present in Github libbpf projection. Is there any
>
>Look on includes from
>tools/lib/bpf/libpf.c
>tools/lib/bpf/bpf.c
>
>That's how it's done... Copping headers to arch/arm will not
>solve this, it includes both of them anyway, and anyway it needs
>asm/unistd.h inclusion here, only because xsk.c needs __NR_*
>
>

There is one more radical solution for this I can send, but I'm not sure how it
can impact on other syscals/arches...

Looks like:


diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 9312066a1ae3..8b2f8ff7ce44 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -113,6 +113,7 @@ override CFLAGS += -Werror -Wall
 override CFLAGS += -fPIC
 override CFLAGS += $(INCLUDES)
 override CFLAGS += -fvisibility=hidden
+override CFLAGS += -D_FILE_OFFSET_BITS=64
 
 ifeq ($(VERBOSE),1)
   Q =
diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
index f2fc40f9804c..ff2d03b8380d 100644
--- a/tools/lib/bpf/xsk.c
+++ b/tools/lib/bpf/xsk.c
@@ -75,23 +75,6 @@ struct xsk_nl_info {
 	int fd;
 };
 
-/* For 32-bit systems, we need to use mmap2 as the offsets are 64-bit.
- * Unfortunately, it is not part of glibc.
- */
-static inline void *xsk_mmap(void *addr, size_t length, int prot, int flags,
-			     int fd, __u64 offset)
-{
-#ifdef __NR_mmap2
-	unsigned int page_shift = __builtin_ffs(getpagesize()) - 1;
-	long ret = syscall(__NR_mmap2, addr, length, prot, flags, fd,
-			   (off_t)(offset >> page_shift));
-
-	return (void *)ret;
-#else
-	return mmap(addr, length, prot, flags, fd, offset);
-#endif
-}
-
 int xsk_umem__fd(const struct xsk_umem *umem)
 {
 	return umem ? umem->fd : -EINVAL;
@@ -211,10 +194,9 @@ int xsk_umem__create(struct xsk_umem **umem_ptr, void *umem_area, __u64 size,
 		goto out_socket;
 	}
 
-	map = xsk_mmap(NULL, off.fr.desc +
-		       umem->config.fill_size * sizeof(__u64),
-		       PROT_READ | PROT_WRITE, MAP_SHARED | MAP_POPULATE,
-		       umem->fd, XDP_UMEM_PGOFF_FILL_RING);
+	map = mmap(NULL, off.fr.desc + umem->config.fill_size * sizeof(__u64),
+		   PROT_READ | PROT_WRITE, MAP_SHARED | MAP_POPULATE, umem->fd,
+		   XDP_UMEM_PGOFF_FILL_RING);
 	if (map == MAP_FAILED) {
 		err = -errno;
 		goto out_socket;
@@ -228,10 +210,9 @@ int xsk_umem__create(struct xsk_umem **umem_ptr, void *umem_area, __u64 size,
 	fill->ring = map + off.fr.desc;
 	fill->cached_cons = umem->config.fill_size;
 
-	map = xsk_mmap(NULL,
-		       off.cr.desc + umem->config.comp_size * sizeof(__u64),
-		       PROT_READ | PROT_WRITE, MAP_SHARED | MAP_POPULATE,
-		       umem->fd, XDP_UMEM_PGOFF_COMPLETION_RING);
+	map = mmap(NULL, off.cr.desc + umem->config.comp_size * sizeof(__u64),
+		   PROT_READ | PROT_WRITE, MAP_SHARED | MAP_POPULATE, umem->fd,
+		   XDP_UMEM_PGOFF_COMPLETION_RING);
 	if (map == MAP_FAILED) {
 		err = -errno;
 		goto out_mmap;
@@ -552,11 +533,10 @@ int xsk_socket__create(struct xsk_socket **xsk_ptr, const char *ifname,
 	}
 
 	if (rx) {
-		rx_map = xsk_mmap(NULL, off.rx.desc +
-				  xsk->config.rx_size * sizeof(struct xdp_desc),
-				  PROT_READ | PROT_WRITE,
-				  MAP_SHARED | MAP_POPULATE,
-				  xsk->fd, XDP_PGOFF_RX_RING);
+		rx_map = mmap(NULL, off.rx.desc +
+			      xsk->config.rx_size * sizeof(struct xdp_desc),
+			      PROT_READ | PROT_WRITE, MAP_SHARED | MAP_POPULATE,
+			      xsk->fd, XDP_PGOFF_RX_RING);
 		if (rx_map == MAP_FAILED) {
 			err = -errno;
 			goto out_socket;
@@ -571,11 +551,10 @@ int xsk_socket__create(struct xsk_socket **xsk_ptr, const char *ifname,
 	xsk->rx = rx;
 
 	if (tx) {
-		tx_map = xsk_mmap(NULL, off.tx.desc +
-				  xsk->config.tx_size * sizeof(struct xdp_desc),
-				  PROT_READ | PROT_WRITE,
-				  MAP_SHARED | MAP_POPULATE,
-				  xsk->fd, XDP_PGOFF_TX_RING);
+		tx_map = mmap(NULL, off.tx.desc +
+			      xsk->config.tx_size * sizeof(struct xdp_desc),
+			      PROT_READ | PROT_WRITE, MAP_SHARED | MAP_POPULATE,
+			      xsk->fd, XDP_PGOFF_TX_RING);
 		if (tx_map == MAP_FAILED) {
 			err = -errno;
 			goto out_mmap_rx;


If maintainers are ready to accept this I can send.
What do you say?

-- 
Regards,
Ivan Khoronzhuk
