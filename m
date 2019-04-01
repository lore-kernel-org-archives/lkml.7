Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B32C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3932520830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="D64fIzJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387650AbfDARqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:46:00 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45948 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729869AbfDARp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:45:57 -0400
Received: by mail-qt1-f194.google.com with SMTP id v20so11630448qtv.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 10:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=30Rd0uHFJ6FcvFv6nYXQgppLW7M6xR8PgPUnvMpNQF8=;
        b=D64fIzJnB2Pn9b8fmaF22LqiqdovaVyDG97djBllHUoKlhITOsitIad6ULKfbiXh1d
         Y+VnG2WHGMTSRFYCraZ+vWHlaCF38sofn8EkZc1x5VlmY8NgvEwuWuMjH2Yv33tX7BxU
         vLq74dO921W2lAtWF9H/fNwPtAawd1IEFf8WZGFbI3RLZlrqHWqAVf9P4a7H8SoCqkSM
         /XJ1AqnVw9teBBVy4wtZ1tQoOv/n7p8mlg0kTM+kV7zfeZkFsmEaif5pdn5FNL+msqoC
         pnAtGpXXdthomjkZmEqB23g0Hnt5ndCSz0kAQveZFpRONr7VS6Fl+Mx0k8i49ytZIRok
         +J8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=30Rd0uHFJ6FcvFv6nYXQgppLW7M6xR8PgPUnvMpNQF8=;
        b=e7lSBiJzIFRPaDX536tQo7zp+9wcvFs/CewEPkFqITfkbD1tNrxkKrBwj/8gakDLu8
         KFVZCQMdBmg2ydbRR0xJslndVJbYwnun6tKQwdVaWHx2qEWCRZu/KqBxHKMNvcPjrt8Q
         JX0RpQudp+w3ICW3ZtBt18jPvN/H+CI3zMoypyM6AXTwURkioFLpYyfvflUalwt+3i/s
         SWewRL/Kvp+j6C1CuAVkB0NqNjmAWqktdaoBE2sQHnnq6fEUNalMKEMPXXtVyBfnq+Tq
         IolrsVNxjEWsKaKcYhIIqC89bzbr/mB6Gw6TfenGzANWuEa+GjX9RojkCyjr2/JfiJ+z
         VmMg==
X-Gm-Message-State: APjAAAUVLmuRt0vTAN4vuVJW3zqmBJlvNIipY6VeNGlOj88qyX4WZLe3
        YC1kVOqvweHvQMwKvDOxawtNig==
X-Google-Smtp-Source: APXvYqwysBZsothf9XXYEpzh2w8H27pKnHWEgtI6cVVM7WCz8403Lzf/p65BkIrciitiD259a0NwXA==
X-Received: by 2002:a0c:b885:: with SMTP id y5mr53788012qvf.25.1554140756133;
        Mon, 01 Apr 2019 10:45:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id u3sm6057662qtk.97.2019.04.01.10.45.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 10:45:55 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hB10M-00049w-M0; Mon, 01 Apr 2019 14:45:54 -0300
Date:   Mon, 1 Apr 2019 14:45:54 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     syzbot <syzbot+2e3e485d5697ea610460@syzkaller.appspotmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     danielj@mellanox.com, danitg@mellanox.com, dledford@redhat.com,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, parav@mellanox.com,
        swise@opengridcomputing.com, syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in cma_exit_net
Message-ID: <20190401174554.GE6209@ziepe.ca>
References: <0000000000008096f305857b74d1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000008096f305857b74d1@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 10:36:05AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    e3ecb83e Add linux-next specific files for 20190401
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13bc36cd200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=db6c9f2bfeb91a99
> dashboard link: https://syzkaller.appspot.com/bug?extid=2e3e485d5697ea610460
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+2e3e485d5697ea610460@syzkaller.appspotmail.com
> 
> WARNING: CPU: 1 PID: 7 at drivers/infiniband/core/cma.c:4674
> cma_exit_net+0x327/0x390 drivers/infiniband/core/cma.c:4674
> Kernel panic - not syncing: panic_on_warn set ...

Matt: This is why the WARN_ON(!xa_empty()) is so valuable. Magically
syzkaller can find something in this code is buggy.

Mellanox is also showing a different testing failure over the weekend
(use after free or something) from your 'cma: Convert portspace IDRs
to XArray'

If you seem something obvious wrong in that patch please speak
up.. Below is what I applied.

Thanks,
Jason

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 68c997be242930..a8b9c66c85252b 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -39,7 +39,7 @@
 #include <linux/mutex.h>
 #include <linux/random.h>
 #include <linux/igmp.h>
-#include <linux/idr.h>
+#include <linux/xarray.h>
 #include <linux/inetdevice.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -191,10 +191,10 @@ static struct workqueue_struct *cma_wq;
 static unsigned int cma_pernet_id;
 
 struct cma_pernet {
-	struct idr tcp_ps;
-	struct idr udp_ps;
-	struct idr ipoib_ps;
-	struct idr ib_ps;
+	struct xarray tcp_ps;
+	struct xarray udp_ps;
+	struct xarray ipoib_ps;
+	struct xarray ib_ps;
 };
 
 static struct cma_pernet *cma_pernet(struct net *net)
@@ -202,7 +202,8 @@ static struct cma_pernet *cma_pernet(struct net *net)
 	return net_generic(net, cma_pernet_id);
 }
 
-static struct idr *cma_pernet_idr(struct net *net, enum rdma_ucm_port_space ps)
+static
+struct xarray *cma_pernet_xa(struct net *net, enum rdma_ucm_port_space ps)
 {
 	struct cma_pernet *pernet = cma_pernet(net);
 
@@ -247,25 +248,25 @@ struct class_port_info_context {
 static int cma_ps_alloc(struct net *net, enum rdma_ucm_port_space ps,
 			struct rdma_bind_list *bind_list, int snum)
 {
-	struct idr *idr = cma_pernet_idr(net, ps);
+	struct xarray *xa = cma_pernet_xa(net, ps);
 
-	return idr_alloc(idr, bind_list, snum, snum + 1, GFP_KERNEL);
+	return xa_insert(xa, snum, bind_list, GFP_KERNEL);
 }
 
 static struct rdma_bind_list *cma_ps_find(struct net *net,
 					  enum rdma_ucm_port_space ps, int snum)
 {
-	struct idr *idr = cma_pernet_idr(net, ps);
+	struct xarray *xa = cma_pernet_xa(net, ps);
 
-	return idr_find(idr, snum);
+	return xa_load(xa, snum);
 }
 
 static void cma_ps_remove(struct net *net, enum rdma_ucm_port_space ps,
 			  int snum)
 {
-	struct idr *idr = cma_pernet_idr(net, ps);
+	struct xarray *xa = cma_pernet_xa(net, ps);
 
-	idr_remove(idr, snum);
+	xa_erase(xa, snum);
 }
 
 enum {
@@ -4655,10 +4656,10 @@ static int cma_init_net(struct net *net)
 {
 	struct cma_pernet *pernet = cma_pernet(net);
 
-	idr_init(&pernet->tcp_ps);
-	idr_init(&pernet->udp_ps);
-	idr_init(&pernet->ipoib_ps);
-	idr_init(&pernet->ib_ps);
+	xa_init(&pernet->tcp_ps);
+	xa_init(&pernet->udp_ps);
+	xa_init(&pernet->ipoib_ps);
+	xa_init(&pernet->ib_ps);
 
 	return 0;
 }
@@ -4667,10 +4668,10 @@ static void cma_exit_net(struct net *net)
 {
 	struct cma_pernet *pernet = cma_pernet(net);
 
-	idr_destroy(&pernet->tcp_ps);
-	idr_destroy(&pernet->udp_ps);
-	idr_destroy(&pernet->ipoib_ps);
-	idr_destroy(&pernet->ib_ps);
+	WARN_ON(!xa_empty(&pernet->tcp_ps));
+	WARN_ON(!xa_empty(&pernet->udp_ps));
+	WARN_ON(!xa_empty(&pernet->ipoib_ps));
+	WARN_ON(!xa_empty(&pernet->ib_ps));
 }
 
 static struct pernet_operations cma_pernet_operations = {

