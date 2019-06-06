Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B46C28EB4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC912083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbfFFPBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 11:01:24 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:59649 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfFFPBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 11:01:24 -0400
Received: from orion.localdomain ([77.9.2.22]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MTR6K-1h7QsW1L8m-00TomO; Thu, 06 Jun 2019 17:00:40 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org
Subject: drivers: hwmon: i5k_amb: simplify probing / device
Date:   Thu,  6 Jun 2019 17:00:32 +0200
Message-Id: <1559833233-25723-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:IKbxlQPaqwU1YSjaQw5qI+1zFaJ1ESxY5CHkeOHtz5uDKXf1518
 qgDaREwZEi0AN/a78NUG/eyU4aky4EqWUOU+opfuZTX5E+0n2yRcWdYtQ9sCcqFxLsQZi9d
 g/B4bnG+EB5c8P8M8y5kx4+KsFF8Ulnu3XIiG5culpc4HImzA0el9jaAkkSo3Q2nyP9rSN+
 v5zLdMz9RRwCnXXwemesw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hVU4RXuAmJQ=:RnMLN81v2+wSmFuObCxbP0
 W4+UOzWcFK8GxJpTtF2b1RD/i3lii4Wd9OyNH95ZpM3tVC/7n/plODKf1MLN0Ej1idf684DTh
 5v5PjgsxRHqcrP8SozTb7fRU8ADO2I9cxGC0my1gjooPQnWvphmMn4o2nSiwZMjwB9LUo5tyt
 QB0mrJDu12AZerE3ZqFrz33dINuKw76HpCAFFJnOA4JEu9cjeCNeFijiSnzMjHrr4cFX2eS5E
 MHoEQQCZmKzD8H3HRApL4jQiTVxJBDqZoMQycTPOU6fUu5z+X+ZDJcgTEJPbqweccVF/cZBWG
 ml6X3ZPUdiyzQKs5OujyAXIAV2Oq3NlgSnYi8Bylr6FzdPVK1wCgxmilczoRuy5btfbmfBbwK
 gdrXZIzV8T7kg1Ruf2SGE1CGsx01gL7LRrSSWo7nrP/kT1hkp0hqD7hQMEA6W2S9dMu5LGa3k
 CwN1jhyTk7YY8i/JAhMDfg280/w/CrE4YMzI7MeRGJ9l5eXz1tifd3Z1bmUw8sje44wbSvIyp
 MOZ4lb6geaeUVX0Wp3RdWlMBdYDdc5fjwYL4ttS/t0HLLbGHagmdncrGVFAo2AzsjZdrwU1Ym
 V4jQ5YwR4nW7lye1rOaYG6si49+2m3lT1D6TP1GcZ7fyAqxJHHdkYcE1VeR2gdayyONNmLnH/
 xEiOKiYzl3zh1J7Eo/exB9/kb8lRnGTWDKMEI8qHKXptfFRcNFYKZ6Mddp6FnQq+gC1iMvTCd
 QIzky/q5k7i9aFLVGuXU+P2IAKx2Kw07UqI53w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

the current way of device probing looks a bit strange and
uses two redundant tables - one only for the module loading
and another for the actual probing.

Simplifying it by putting everything into the pci match table.


--mtx


