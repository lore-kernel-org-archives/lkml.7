Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6082C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 20:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 807332072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 20:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbgAGUGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 15:06:17 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:60093 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgAGUGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 15:06:17 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MGzDv-1iu8AR0ysl-00E1f1; Tue, 07 Jan 2020 21:06:12 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oleksandr Natalenko <oleksandr@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vme: bridges: reduce stack usage
Date:   Tue,  7 Jan 2020 21:05:43 +0100
Message-Id: <20200107200610.3482901-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JRQQj5uc/jWLmBmcsVbgZFzF/SPQfVM+WL2b7PT514fxILXtI3S
 1UW+0uFFza6RECIGCNd8Hx8++hEDIfQQyVCpwVhkAaxHy8qmEQBTj0kGKRZW9qrBof5N+nA
 UJuZtN3GQwAYKwHFHojXiTAr3EanzGhQ1rK+aYn82mNJ/gKyVeClYCLBY3EJ5cc9YysVmW1
 dSxaajJkgyaJK5EQ12jMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Qwc2FlRa0HY=:bo6VqV0/kfs0BM2gR1mFdl
 dLdJp0uzjwnjorHeBYlq0zCsffb9xMeDzjvVuJ3jotfiBKyZRl3lhqeAyAuMWTTT5Gf45fRVO
 HG+5L0KxA2Fw8iFofSLqeUrlzjZN7yIOHb3sQHNibgXJYnFaXNPCi8iRB65r7zAGJ/bRV3Zwl
 2ABi8a62gC9LukUUIlNVL6QTcoOYchpm0Qf49XdXrxVi2eLmml/dUGcjd0DQURAg7A3U1lY/i
 5ercQpXdGVMHhDzaXymAPn6TCdQJ+69TIh8CcdKKA5QBO/dQNJXtkIjdGVtqpu+H91dhcLpYR
 1a/Dbc1uNUufSSpAAyzSXfOSZaZSAPg0WOi3usYzM3Vo4dfLCVm/GZMH9jPxyl7TJ/62dlfDc
 nQkNmoa2tyVsc62w7fHhDRAzAG80pY5LmXQZcR5GiHIIzzUtXi5rcGnCBEw4Wl6XddwrxZpVW
 3OnIJImtvqOWso8MDDQGVWPCfZZNreoHf0vfGZuqchgevDg192GP5VC4YeQBHql9hNu08A7KD
 NfcIEZeh2gtZB6ESJ6+KkljELPF6m0gL9d1Strnhx2Uq/pt7qtrsf0yY5yfRe+FRz089zAFFr
 XzKbYOfZ5RCpWGAG3yduN5pf2j7xv1qjI6Xt0IeSIORyaTIyP1LET5uubK8kPAqVJXWdkxUuQ
 F5D8JX/BMlVZT0ouWXh6tPKJ6ubLBwJ26DkhevCJzskmO9f9LUaUUi2uJrGx62HGj/P/ci2x6
 CJ4YUbLeDkEJpRMcAlxkIJzvtzopPR+Xx2PKpCmM1n1wuGmgRE8re6ZVUMupH2+kcQzBknGt4
 xkw9nW/EUIuIuDP3tO8RU/YXMIUozhGT4ee6Wi/m8RCzpk+L2U/X0zOiX5kda8Lrr2rNu5mnD
 v6oWqffBfT9cAhb1AB1Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3, the stack usage in vme_fake
grows above the warning limit:

drivers/vme/bridges/vme_fake.c: In function 'fake_master_read':
drivers/vme/bridges/vme_fake.c:610:1: error: the frame size of 1160 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
drivers/vme/bridges/vme_fake.c: In function 'fake_master_write':
drivers/vme/bridges/vme_fake.c:797:1: error: the frame size of 1160 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

The problem is that in some configurations, each call to
fake_vmereadX() puts another variable on the stack.

Reduce the amount of inlining to get back to the previous state,
with no function using more than 200 bytes each.

Fixes: mmtom ("init/Kconfig: enable -O3 for all arches")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/vme/bridges/vme_fake.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/vme/bridges/vme_fake.c b/drivers/vme/bridges/vme_fake.c
index 3208a4409e44..6a1bc284f297 100644
--- a/drivers/vme/bridges/vme_fake.c
+++ b/drivers/vme/bridges/vme_fake.c
@@ -414,8 +414,9 @@ static void fake_lm_check(struct fake_driver *bridge, unsigned long long addr,
 	}
 }
 
-static u8 fake_vmeread8(struct fake_driver *bridge, unsigned long long addr,
-		u32 aspace, u32 cycle)
+static noinline_for_stack u8 fake_vmeread8(struct fake_driver *bridge,
+					   unsigned long long addr,
+					   u32 aspace, u32 cycle)
 {
 	u8 retval = 0xff;
 	int i;
@@ -446,8 +447,9 @@ static u8 fake_vmeread8(struct fake_driver *bridge, unsigned long long addr,
 	return retval;
 }
 
-static u16 fake_vmeread16(struct fake_driver *bridge, unsigned long long addr,
-		u32 aspace, u32 cycle)
+static noinline_for_stack u16 fake_vmeread16(struct fake_driver *bridge,
+					     unsigned long long addr,
+					     u32 aspace, u32 cycle)
 {
 	u16 retval = 0xffff;
 	int i;
@@ -478,8 +480,9 @@ static u16 fake_vmeread16(struct fake_driver *bridge, unsigned long long addr,
 	return retval;
 }
 
-static u32 fake_vmeread32(struct fake_driver *bridge, unsigned long long addr,
-		u32 aspace, u32 cycle)
+static noinline_for_stack u32 fake_vmeread32(struct fake_driver *bridge,
+					     unsigned long long addr,
+					     u32 aspace, u32 cycle)
 {
 	u32 retval = 0xffffffff;
 	int i;
@@ -609,8 +612,9 @@ static ssize_t fake_master_read(struct vme_master_resource *image, void *buf,
 	return retval;
 }
 
-static void fake_vmewrite8(struct fake_driver *bridge, u8 *buf,
-			   unsigned long long addr, u32 aspace, u32 cycle)
+static noinline_for_stack void fake_vmewrite8(struct fake_driver *bridge,
+					      u8 *buf, unsigned long long addr,
+					      u32 aspace, u32 cycle)
 {
 	int i;
 	unsigned long long start, end, offset;
@@ -639,8 +643,9 @@ static void fake_vmewrite8(struct fake_driver *bridge, u8 *buf,
 
 }
 
-static void fake_vmewrite16(struct fake_driver *bridge, u16 *buf,
-			    unsigned long long addr, u32 aspace, u32 cycle)
+static noinline_for_stack void fake_vmewrite16(struct fake_driver *bridge,
+					       u16 *buf, unsigned long long addr,
+					       u32 aspace, u32 cycle)
 {
 	int i;
 	unsigned long long start, end, offset;
@@ -669,8 +674,9 @@ static void fake_vmewrite16(struct fake_driver *bridge, u16 *buf,
 
 }
 
-static void fake_vmewrite32(struct fake_driver *bridge, u32 *buf,
-			    unsigned long long addr, u32 aspace, u32 cycle)
+static noinline_for_stack void fake_vmewrite32(struct fake_driver *bridge,
+					       u32 *buf, unsigned long long addr,
+					       u32 aspace, u32 cycle)
 {
 	int i;
 	unsigned long long start, end, offset;
-- 
2.20.0

