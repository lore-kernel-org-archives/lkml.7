Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAE7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AD1020693
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553259909;
	bh=ladJYFiMqQkcDHLCgdjDNr9Ut/c9XcELNIgK2p+BBgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nkd4+87IfWYOOUAcVHQitHqPNGgrCuZISzRYQPJBVhhhJmlI3Zh6E1YNKgrQc6beg
	 HvcO31iV3atx/2APL7grf4IopTCEgyN5q2HaQLzdHRJH/8nOAn9CVGSHf6+tDuYqli
	 vIexnaZf7U6Odh4YD8YdVcwJEDDoOOgsxiJPcgqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbfCVLjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:39:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731078AbfCVLjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:39:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 884B82082C;
        Fri, 22 Mar 2019 11:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254752;
        bh=ladJYFiMqQkcDHLCgdjDNr9Ut/c9XcELNIgK2p+BBgY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YzD8o6de2Jibe2ORG1T254J+azh6OJDRDnuJDyy3eY1SYaav+IJa+rzuclE6lNklc
         m0j7vgSF74R0sAB443xgllP/ldGYdd5ctYFgN3jBx/54liuXiV33Aev8bdSaMfmxbZ
         NYbrW/ZPkIjgc2N9NNhenU3p4NU/Cql/UQ7cC3IU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neil@brown.name>,
        Mike Snitzer <snitzer@redhat.com>,
        =?UTF-8?q?Guillaume=20Perr=C3=A9al?= <gperreal@free.fr>
Subject: [PATCH 4.4 214/230] dm: fix to_sector() for 32bit
Date:   Fri, 22 Mar 2019 12:15:52 +0100
Message-Id: <20190322111251.887145062@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neil@brown.name>

commit 0bdb50c531f7377a9da80d3ce2d61f389c84cb30 upstream.

A dm-raid array with devices larger than 4GB won't assemble on
a 32 bit host since _check_data_dev_sectors() was added in 4.16.
This is because to_sector() treats its argument as an "unsigned long"
which is 32bits (4GB) on a 32bit host.  Using "unsigned long long"
is more correct.

Kernels as early as 4.2 can have other problems due to to_sector()
being used on the size of a device.

Fixes: 0cf4503174c1 ("dm raid: add support for the MD RAID0 personality")
cc: stable@vger.kernel.org (v4.2+)
Reported-and-tested-by: Guillaume Perréal <gperreal@free.fr>
Signed-off-by: NeilBrown <neil@brown.name>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/device-mapper.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -593,7 +593,7 @@ extern struct ratelimit_state dm_ratelim
  */
 #define dm_target_offset(ti, sector) ((sector) - (ti)->begin)
 
-static inline sector_t to_sector(unsigned long n)
+static inline sector_t to_sector(unsigned long long n)
 {
 	return (n >> SECTOR_SHIFT);
 }


