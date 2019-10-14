Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06841C47404
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7857207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbfJNHKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 03:10:01 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:18427 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726500AbfJNHKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 03:10:01 -0400
X-UUID: c543ae8dd49b4ae3801dbf275282df1a-20191014
X-UUID: c543ae8dd49b4ae3801dbf275282df1a-20191014
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <jing-ting.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 861174270; Mon, 14 Oct 2019 15:09:55 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 14 Oct 2019 15:09:52 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 14 Oct 2019 15:09:53 +0800
From:   Jing-Ting Wu <jing-ting.wu@mediatek.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        <wsd_upstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 1/1] sched/rt: avoid contend with CFS task
Date:   Mon, 14 Oct 2019 15:09:07 +0800
Message-ID: <1571036948-25034-1-git-send-email-jing-ting.wu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:
We have revised the implementation to select a better idle CPU
in the same sched_domain of prev_cpu (with the same cache hotness)
when the RT task wakeup.


