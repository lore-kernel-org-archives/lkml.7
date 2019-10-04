Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F43C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 059A820873
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="YfMx+/ht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbfJDVyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 17:54:50 -0400
Received: from mout.gmx.net ([212.227.17.21]:49969 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbfJDVyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 17:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570226048;
        bh=B8UvUYEF9Jx7mfHiXjKQ9ieRk6WlKja4/H0KNgjq6/g=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=YfMx+/htXJeNvW4HQApwMRKi1SmpF+HT43N1rI1Jnrcb5EliKWCQgVZKd/SG04BwY
         ilRNpJuq9rtKbIGR8CoFRSX+j2sLfPbjsScwIHU4XtFxaqFtaoxySpafySyaFENSfT
         4VX118N2C7nMvS1+uO2Qxz9CDPoGPhCapUYZGUaI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([89.0.25.131]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRmjq-1iiZwz2wR8-00TFzL; Fri, 04
 Oct 2019 23:54:08 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     rcu@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rculist: Describe variadic macro argument in a Sphinx-compatible way
Date:   Fri,  4 Oct 2019 23:54:02 +0200
Message-Id: <20191004215402.28008-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZOzJWGD9fboKlyMdu8wnj0mmctk3XOAzMJRgM4mcdAMsFhSuMF8
 ysTGR2ppxjuWp0YIsO6Azpt2lDG23KEEOLUTiR1sFtapuxmQu6/ZTSEJl/2o0Bw00J64KN6
 36Zg+IU1257/5WeOTfkfqwArM5rLa3+ZJo1U3FqNzBcYF+ceGPG1r579V3Pu74fI9H8/ZDq
 dsL/oQv4bia782lCYCVcA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1zmG1LY4qBg=:fk+3hZ31jwadfwSSUPYqU2
 YcazqouEJRJe5ADQmpltwO2iXf1/IY2OBBYvY22m6YDkKtzzm6O59oR8LLjdbCmITfikCMSuG
 crg6duW8HpuwZ9v/7Iz5jpgmlLs2fezN3vZfngTJSRnxH9SNq1ZyX2EkcvtZr/9KyxCEIged8
 8FO2DMDKSiBu5/+bXWC3QpFQNPV3KjqXbVOFkalKlWDCIzZEtKpLslGjNqhP8hc0usp0VF+S9
 Q3VMXk7C6DFnzbHEUsWWOviNfF3+f77kdszbx1QwG0xpvFvPHXQKv6j2ClhCseJogAKjU3R+L
 NWjKHWHxHTRjpJ22xfxshdFJ6JYNdTvYenMbt0esrU9Q1lJ+qqNgHFNr31enNb9qLcdePGeNa
 4oYM1+45EfB1elDnDG8EavuK2ukz/G9HnDAj1fof7+laOldU1I2wtqbepo/Sysma7IrntKoVP
 upT8GGABgxfBp5MSdeRgyZwIY8F6gyH4L6Ik2sWiyHTFhnfK4Cs1LRNMFBpieMsIJdbnlaciq
 a0hoSEPqj4pBTQh3tsn3KDodRRR78+F6tePGo8rXRmlnbIvLr8Z4y4eYXrZUBAquoeYCCuFSd
 P4VDLC1ArCpFbreqmZVOmNxGUPHsrcDSieLItTTLtCLfdfWiARb9L+XJh7Ol9gt8Cn6cTISao
 4A2o9Q2ccfDtX2CMwN151iwcDLzEdGwlEqSWGY8bFWLRpS2wBRT3/0d7X6ovlzizlpVAudiUb
 m5KVb9ekl/V+Nnfr59pu4cMok/23nalILfpBOBXT+t28nIdoBVoDxNZ7w1fr1H5ZrZrpM+V3K
 4di6fBZaCYCSeLIkZs/hxxVyeDkX0pgz7F/CK+BN0c8qSCO3E8beKM/64bUqEKYiHG/L1pO9v
 kWTmMdrlFvguQ3zhu1XYS6AFaUouilfshjQNS6+jX5QSX/7ScbdBxS6hfTrkgFLnp2es6Ump5
 OK3bHpf5DCSUWqdeYW/jOy2OCG3hLftj3rixq8KFwAWDwAgyrfnpKijMMA5edNX0qOQkjgsYv
 PKr6r/qM1sqyJTcz/6QhsF+V26fbhE1HwopvUips3Ak5HLMAXliH0XWOKk0tcGUOSXS+dKcUI
 zimXkcr7EX4G2L4TCk9llgHKFVeXxejRvpqtX3To2PjZSDHBRD4M4AuekW1L1sMIaKZR9bMhj
 XvkwkkqZUH+l38l2+tOO2Nej4HwqwShNQOQ9wLt70IbJPzed2lveu0pBwKvTEZAbdfYj0mly5
 +Rx++BKCtNdr1Hj7pqu4QvLtVJpdZeSrb7sqzk8dXC7bmEoWgL/so21yrSfg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this patch, Sphinx shows "variable arguments" as the description
of the cond argument, rather than the intended description, and prints
the following warnings:

./include/linux/rculist.h:374: warning: Excess function parameter 'cond' d=
escription in 'list_for_each_entry_rcu'
./include/linux/rculist.h:651: warning: Excess function parameter 'cond' d=
escription in 'hlist_for_each_entry_rcu'

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 include/linux/rculist.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 4158b7212936..61c6728a71f7 100644
=2D-- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -361,7 +361,7 @@ static inline void list_splice_tail_init_rcu(struct li=
st_head *list,
  * @pos:	the type * to use as a loop cursor.
  * @head:	the head for your list.
  * @member:	the name of the list_head within the struct.
- * @cond:	optional lockdep expression if called from non-RCU protection.
+ * @cond...:	optional lockdep expression if called from non-RCU protectio=
n.
  *
  * This list-traversal primitive may safely run concurrently with
  * the _rcu list-mutation primitives such as list_add_rcu()
@@ -636,7 +636,7 @@ static inline void hlist_add_behind_rcu(struct hlist_n=
ode *n,
  * @pos:	the type * to use as a loop cursor.
  * @head:	the head for your list.
  * @member:	the name of the hlist_node within the struct.
- * @cond:	optional lockdep expression if called from non-RCU protection.
+ * @cond...:	optional lockdep expression if called from non-RCU protectio=
n.
  *
  * This list-traversal primitive may safely run concurrently with
  * the _rcu list-mutation primitives such as hlist_add_head_rcu()
=2D-
2.20.1

