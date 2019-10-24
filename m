Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C28FCA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 09:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604982166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 09:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="f9smkoN4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390079AbfJXJ36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 05:29:58 -0400
Received: from sender4-pp-o94.zoho.com ([136.143.188.94]:25484 "EHLO
        sender4-pp-o94.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732032AbfJXJ35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 05:29:57 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571909364; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=P9v8S+T/aSvPxpLtfGnb/Aj/FOqG4F1JcOV15pTqDvpDF72pHDgq8BcLhMBKldXAJ49ZQhIRmkfC5FYnY68rEQgMPkYM0U5m8S6C8p6df8P3/C7EzIF6TVuh5iGw2sTTfCY50Ci16yIgZUUNtDVCfCBqN1XwIMDbdjF7c98tB54=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1571909364; h=Cc:Date:From:Message-ID:Subject:To; 
        bh=E6SJtj7SgWDgqxZyq+RY+asKIpxFZx/oK0gQ7wFDxMw=; 
        b=nYOHrbkp0LDdBrS8FSTulnu4Drv/PgV3ZKqmiGHzEoTZByEnmLS66KSJThV2LLwUVvhqRZ/WhMTHnC9vl4sQ3SL7hSWhWyGwWiExQ/kuMBQYbODvkx6FTSbUp5zMiAFfWDXvlZPEHtEUg5jiVLFN5j03++jtkq1pAzjlkKwXAfM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=HYwOxV+AgJpaVqqk+wQHanf6YHfOoGoiZGCBrnKTM46UGMiHtQK5D6t0I5k3JkXNkz6K3rmVyJ/J
    2JOGzhccBX4OIS87TBROeFFLsat63VIM+W9Czrfv/sjhIQXxklz8  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1571909364;
        s=zm2019; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id; l=65;
        bh=E6SJtj7SgWDgqxZyq+RY+asKIpxFZx/oK0gQ7wFDxMw=;
        b=f9smkoN4yiFGDbMdt6MNY1jNntfgjB3GynSsOcMX4m9HYypaGDCMgDcMR/Vk74R/
        GL5Ue4KDj9reLixGuGBIF8GTs9Wp7EpUbo80TA7XL83Xgwm1zzg+x25+X7+39udampt
        ogqUh7bTnRI0SV8wom/iV0jvQPorokND0/xoi9k0=
Received: from zhouyanjie-virtual-machine.localdomain (182.148.156.27 [182.148.156.27]) by mx.zohomail.com
        with SMTPS id 1571909359956612.7028861589881; Thu, 24 Oct 2019 02:29:19 -0700 (PDT)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, ralf@linux-mips.org,
        jhogan@kernel.org, gregkh@linuxfoundation.org,
        paul.burton@mips.com, chenhc@lemote.com, paul@crapouillou.net,
        tglx@linutronix.de, jiaxun.yang@flygoat.com
Subject: MIPS: Ingenic: Disable abandoned HPTLB function. 
Date:   Thu, 24 Oct 2019 17:28:59 +0800
Message-Id: <1571909341-10108-1-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.rename JZRISC to XBurst.
2.disable abandoned HPTLB function.


