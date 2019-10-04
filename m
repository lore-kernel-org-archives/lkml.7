Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C1CC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 19:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B37A52084D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 19:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pimaker.at header.i=@pimaker.at header.b="u353UxAF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730989AbfJDTtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 15:49:19 -0400
Received: from mail4.protonmail.ch ([185.70.40.27]:11038 "EHLO
        mail4.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729542AbfJDTtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 15:49:18 -0400
Date:   Fri, 04 Oct 2019 19:49:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pimaker.at;
        s=protonmail; t=1570218555;
        bh=AS1CxfhygLyImk+JuXN7jBRLdNimwE9AoO8eGMwC5/g=;
        h=Date:To:From:Cc:Reply-To:Subject:Feedback-ID:From;
        b=u353UxAF/aC7YxxXkPdPXOQPoJzP+gMijoZGyE8P6AtP5GMibLaiDmuz3kHZ6+QwG
         UGNn85jI52Y7R7fWKYt3yO2Y9Q2nHoM98BmlDkpAuoy4yLxiIBL+dmwWcipSljQ08N
         uUM1lIHSr5PyJggQ08s7xzzC8lwhUq1qsU0T7S9o=
To:     rcu@vger.kernel.org
From:   Stefan Reiter <stefan@pimaker.at>
Cc:     Stefan Reiter <stefan@pimaker.at>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Reply-To: Stefan Reiter <stefan@pimaker.at>
Subject: [PATCH] rcu/nocb: Fix dump_tree hierarchy print always active
Message-ID: <20191004194854.11352-1-stefan@pimaker.at>
Feedback-ID: ue9Y3QtBlktHf6EEpXP3zzomX_ELv4nrMskJ1DJAqtnBErUqnmreyaap-KHUztlMofpS6GrkVvbLJ97c2ByOFQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 18cd8c93e69e ("rcu/nocb: Print gp/cb kthread hierarchy if
dump_tree") added print statements to rcu_organize_nocb_kthreads for
debugging, but incorrectly guarded them, causing the function to always
spew out its message.

This patch fixes it by guarding both pr_alert statements with dump_tree,
while also changing the second pr_alert to a pr_cont, to print the
hierarchy in a single line (assuming that's how it was supposed to
work).

Fixes: 18cd8c93e69e ("rcu/nocb: Print gp/cb kthread hierarchy if dump_tree"=
)
Signed-off-by: Stefan Reiter <stefan@pimaker.at>
---

First time contributing to the kernel, hope I'm doing this right :)

 kernel/rcu/tree_plugin.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 2defc7fe74c3..7cbf4a0f3eff 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2346,15 +2346,19 @@ static void __init rcu_organize_nocb_kthreads(void)
 =09=09=09nl =3D DIV_ROUND_UP(rdp->cpu + 1, ls) * ls;
 =09=09=09rdp->nocb_gp_rdp =3D rdp;
 =09=09=09rdp_gp =3D rdp;
-=09=09=09if (!firsttime && dump_tree)
-=09=09=09=09pr_cont("\n");
-=09=09=09firsttime =3D false;
-=09=09=09pr_alert("%s: No-CB GP kthread CPU %d:", __func__, cpu);
+=09=09=09if (dump_tree) {
+=09=09=09=09if (!firsttime)
+=09=09=09=09=09pr_cont("\n");
+=09=09=09=09firsttime =3D false;
+=09=09=09=09pr_alert("%s: No-CB GP kthread CPU %d:",
+=09=09=09=09=09 __func__, cpu);
+=09=09=09}
 =09=09} else {
 =09=09=09/* Another CB kthread, link to previous GP kthread. */
 =09=09=09rdp->nocb_gp_rdp =3D rdp_gp;
 =09=09=09rdp_prev->nocb_next_cb_rdp =3D rdp;
-=09=09=09pr_alert(" %d", cpu);
+=09=09=09if (dump_tree)
+=09=09=09=09pr_cont(" %d", cpu);
 =09=09}
 =09=09rdp_prev =3D rdp;
 =09}
--=20
2.23.0


