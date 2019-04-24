Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB50C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBBB7218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbfDXKe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:34:59 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:38485 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbfDXKe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:34:58 -0400
Received: from orion.localdomain ([95.114.95.254]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M4K2r-1hJWDj49Wz-000How; Wed, 24 Apr 2019 12:34:51 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, linux-ide@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: libata fixes for NVME + OPAL
Date:   Wed, 24 Apr 2019 12:34:38 +0200
Message-Id: <1556102081-11820-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:QWeA5Fetrux63+pUZh2lVQqXIa+Q7g1akJBzgZQsEfXq166C7Fu
 4SZ8BIVdFyXQ3uuF6P72faCn94IQHLikS6rHm/upIqFhRAQLmYo62DXeIuNcTpw4X0k418U
 /ITuqSDVVxX+oeQrY2N4+U/CwI8VywyLSNlCx+/mf79XLMqttRfxDaBrEdQKkxt9H2urk78
 Awn6YPSovw/xVTLkZ9wtA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CouuiYiQoLg=:LypaoNDllVpZvBjFS/Z0gh
 ArVZ9HDFwGIyX/EMZqWDNs8Zi/uQJYINtUM2ubEh33/B5i6Sx3TO3MX5T4yXc0nhjbxzfB9M3
 XiE4QIwIOVIsXD7uHUKUNHxCivOUjHfB+K0NmcaDu/HXzUD66+hqb3CzaqXGvGNegGVeErTan
 hwNVf76zFAfDXjYL4Tvjjqw00ny9Z1pMHtncbGJn7e6q2v7gSDCrKi5kPgBsUqatqKoI21aEQ
 F8GRyZC3HrG9zXu3nI6nTvTg98CwZcKVH6a9Ps2+Oa7PB6ywzs8WrO3tDgLm87Yxd4ks0p/uY
 uhhPG9Y6wKgAMY7B2aa+BZT/qTolp/Nlam4BEoNShybGYfRZYu/fx6SDDB2cVfmaFEeC3qZtd
 mSP+PGrD+2jjhqFFHeZtbFtjM3Y1ZbYyS+GhdXldiZSlPDygZwHq14QpMh20k/VN3o2/MJeMc
 nGnv2Et1Cz0gjWIZb1OcPZfWvDy+rvzFOHagdcXXqh1jG1N+CMbbHHImPHpoxKVrbqAgm+Wcu
 yvhLUscWVDefhkM/GFTlbZyOnoGkN4FouM3ETu6BBYLbFn5CGuPZ0K/DPQ3Qul5IVqJpYaINo
 bDfVc3wvT0gcaHA3OEwbeqp24iF2lnzOAnfyFCJP4XBQ8fzkrvw8E2XqjYyVclFT8H61RoK8T
 +mpZ34I/gXKDQzLAUcXv4ICoglDhLLoAyxgfIsaBFnt4Yy65RdiNmOWagvoKYIis6rTlcW0TV
 S2kN6UztVZjPyfbJjLAMzFq19B39RcNV1pJBgA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,


here're some fixes for libata to make NVME and TCG OPAL work:

* fix a little build break in nvme (forgotten include and Kconfig select)
* introduce sysctl knob for enabling tpm stuff at runtime
  (sed-util expects since several years, so it seems that piece just might
  have been forgotten when opal support was mainlined)


--mtx
