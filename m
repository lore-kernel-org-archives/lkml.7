Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF44C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CDB7204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255939;
	bh=vuNW1LEWwRiD7aquPTeixFyYQtTqgO2ATrGLSTy7CwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uu5DyX/Vd71k81RVflg80WQtiBSVmjutbnsaz459rQP6if5DAx8OHPQvjIYoFq5L/
	 5lLWwShG6CflSxkd57xs8PjcTyI/QAhjSlQVc+HmPMhiBzvnMHOStAwsC0iEn2nvum
	 t4OORiBrL+pqCeemPUdmMmomiuzOOshZXIpqDvUk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387913AbfCVL66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:58:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387902AbfCVL6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:58:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BC892192D;
        Fri, 22 Mar 2019 11:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255934;
        bh=vuNW1LEWwRiD7aquPTeixFyYQtTqgO2ATrGLSTy7CwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=daGPUkbEbhe54YPcOzjv9u07+IwYRa8AxN2vdp4pQsTkNndFQ2Qh5C+ij8Klw5WSj
         aCQRWRT8wM7aKpbKHpkfn+STXTH32NTs1uVoB47rpTZkc04jrcKd/67CvP+BZdSD7c
         Tu851ZMMJPx9uGGZE95FM4NNc5hMNZRXWkNosvxc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 059/280] net: dsa: bcm_sf2: potential array overflow in bcm_sf2_sw_suspend()
Date:   Fri, 22 Mar 2019 12:13:32 +0100
Message-Id: <20190322111309.587317577@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 8d6ea932856c7087ce8c3d0e79494b7d5386f962 ]

The value of ->num_ports comes from bcm_sf2_sw_probe() and it is less
than or equal to DSA_MAX_PORTS.  The ds->ports[] array is used inside
the dsa_is_user_port() and dsa_is_cpu_port() functions.  The ds->ports[]
array is allocated in dsa_switch_alloc() and it has ds->num_ports
elements so this leads to a static checker warning about a potential out
of bounds read.

Fixes: 8cfa94984c9c ("net: dsa: bcm_sf2: add suspend/resume callbacks")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Vivien Didelot <vivien.didelot@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/bcm_sf2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index fc8b48adf38b..bb26a193361e 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -692,7 +692,7 @@ static int bcm_sf2_sw_suspend(struct dsa_switch *ds)
 	 * port, the other ones have already been disabled during
 	 * bcm_sf2_sw_setup
 	 */
-	for (port = 0; port < DSA_MAX_PORTS; port++) {
+	for (port = 0; port < ds->num_ports; port++) {
 		if (dsa_is_user_port(ds, port) || dsa_is_cpu_port(ds, port))
 			bcm_sf2_port_disable(ds, port, NULL);
 	}
-- 
2.19.1



