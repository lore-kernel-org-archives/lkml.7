Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E3CC17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D8821872
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FDyy21Bw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfKLHvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 02:51:21 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39360 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725283AbfKLHvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 02:51:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573545079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6rxyS/tsYPHxeVrlM+DEscFIUAW4qtSS92/VNhtKh8c=;
        b=FDyy21BwZ80ftKEcM0ECsAdtBsRVMG4FU1eamOyZ1GA7jif0KBOoFLIgvaagxrH30nflZk
        qaL4oPyIIxgL8Xchgt2CTiGO6dBTiS0uNRF/0VtpW6dNynKVnluR7SPrpX48drJhPcV82T
        hcy8VJIF/b8SvahcvmeTq+6vOvct+h0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-Wj5eCjiIOCSLICFjqeDrCw-1; Tue, 12 Nov 2019 02:51:18 -0500
Received: by mail-wr1-f70.google.com with SMTP id h7so11250054wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 23:51:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VsvZFQRI2YV26AAOzKX2AI/mJO4c1Kc1kKEKWftHXnQ=;
        b=GUGvK5QHTm3YoDwz+lvqhFxuLilo1QsjoPG4IrAW6NGYX0zyxwwGZaKHlyEfTx4swV
         ZCMBdMC3zbYPLwfTkCNMtlRNSPJPn7eHRrmSSMvf+nzPLRo1lvI6t0jp5ZEzA3HFkwji
         No5a8ZdxgsbJD1YiLDmb3hlq8nQXfwH2PjP6fWy4BJ8PDPkqWiHyu5aiuIJI+pYCLV2V
         T4xW+psmzUPmhFCcMYnzceKYyMnt84zQT80Fg1p+vpT6uMU90vVxtPXu8xiddWzop3qI
         I14Tey+/E/aVNbsOFQ7wH96yngINNXIB4ZrIlAhLULGbicWNCiAk363vttTBSslTPijC
         C97A==
X-Gm-Message-State: APjAAAVlmoExKaqNztCa/SlhWCq4I121kRUqgUNm9t4nZWjGtvZHFQju
        Rb8xxXTqcrrRo3N4IU9CEbQA9+qk1q4C7jxGa1d5LZ0wSFUaYCJHWF57PbRBgN1OHtbhtbY+vTj
        5P5H99b7asohgtN+pZm2q27df
X-Received: by 2002:a1c:2846:: with SMTP id o67mr2637224wmo.7.1573545076088;
        Mon, 11 Nov 2019 23:51:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqxEVCMatQKEK93qgShSFL6xhXuoOiSzVJOt45BVZF+3Mq9tvSydYKZ6+TQCkfM5J0Mr4VyjYg==
X-Received: by 2002:a1c:2846:: with SMTP id o67mr2637212wmo.7.1573545075797;
        Mon, 11 Nov 2019 23:51:15 -0800 (PST)
Received: from localhost.localdomain.com ([151.29.177.194])
        by smtp.gmail.com with ESMTPSA id i71sm39498658wri.68.2019.11.11.23.51.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Nov 2019 23:51:14 -0800 (PST)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, glenn@aurora.tech
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        tglx@linutronix.de, luca.abeni@santannapisa.it,
        c.scordino@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, juri.lelli@redhat.com
Subject: [PATCH 2/2] sched/deadline: Temporary copy static parameters to boosted non-DEADLINE entities
Date:   Tue, 12 Nov 2019 08:50:56 +0100
Message-Id: <20191112075056.19971-3-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191112075056.19971-1-juri.lelli@redhat.com>
References: <20191112075056.19971-1-juri.lelli@redhat.com>
X-MC-Unique: Wj5eCjiIOCSLICFjqeDrCw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boosted entities (Priority Inheritance) use static DEADLINE parameters
of the top priority waiter. However, there might be cases where top
waiter could be a non-DEADLINE entity that is currently boosted by a
DEADLINE entity from a different lock chain (i.e., nested priority
chains involving entities of non-DEADLINE classes). In this case, top
waiter static DEADLINE parameters could null (initialized to 0 at
fork()) and replenish_dl_entity() would hit a BUG().

Fix this by temporarily copying static DEADLINE parameters of top
DEADLINE waiter (there must be at least one in the chain(s) for the
problem above to happen) into boosted entities. Parameters are reset
during deboost.

Reported-by: Glenn Elliott <glenn@aurora.tech>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/sched/core.c     |  6 ++++--
 kernel/sched/deadline.c | 17 +++++++++++++++++
 kernel/sched/sched.h    |  1 +
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7880f4f64d0e..a3eb57cfcfb4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4441,19 +4441,21 @@ void rt_mutex_setprio(struct task_struct *p, struct=
 task_struct *pi_task)
 =09=09if (!dl_prio(p->normal_prio) ||
 =09=09    (pi_task && dl_entity_preempt(&pi_task->dl, &p->dl))) {
 =09=09=09p->dl.dl_boosted =3D 1;
+=09=09=09if (!dl_prio(p->normal_prio))
+=09=09=09=09__dl_copy_static(p, pi_task);
 =09=09=09queue_flag |=3D ENQUEUE_REPLENISH;
 =09=09} else
 =09=09=09p->dl.dl_boosted =3D 0;
 =09=09p->sched_class =3D &dl_sched_class;
 =09} else if (rt_prio(prio)) {
 =09=09if (dl_prio(oldprio))
-=09=09=09p->dl.dl_boosted =3D 0;
+=09=09=09__dl_clear_params(p);
 =09=09if (oldprio < prio)
 =09=09=09queue_flag |=3D ENQUEUE_HEAD;
 =09=09p->sched_class =3D &rt_sched_class;
 =09} else {
 =09=09if (dl_prio(oldprio))
-=09=09=09p->dl.dl_boosted =3D 0;
+=09=09=09__dl_clear_params(p);
 =09=09if (rt_prio(oldprio))
 =09=09=09p->rt.timeout =3D 0;
 =09=09p->sched_class =3D &fair_sched_class;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 951a7b44156f..a823391b245e 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2676,6 +2676,22 @@ bool __checkparam_dl(const struct sched_attr *attr)
 =09return true;
 }
=20
+/*
+ * This function clears the sched_dl_entity static params.
+ */
+void __dl_copy_static(struct task_struct *to, struct task_struct *from)
+{
+=09struct sched_dl_entity *to_se =3D &to->dl;
+=09struct sched_dl_entity *from_se =3D &from->dl;
+
+=09to_se->dl_runtime=09=3D from_se->dl_runtime;
+=09to_se->dl_deadline=09=3D from_se->dl_deadline;
+=09to_se->dl_period=09=3D from_se->dl_period;
+=09to_se->flags=09=09=3D from_se->flags;
+=09to_se->dl_bw=09=09=3D from_se->dl_bw;
+=09to_se->dl_density=09=3D from_se->dl_density;
+}
+
 /*
  * This function clears the sched_dl_entity static params.
  */
@@ -2690,6 +2706,7 @@ void __dl_clear_params(struct task_struct *p)
 =09dl_se->dl_bw=09=09=09=3D 0;
 =09dl_se->dl_density=09=09=3D 0;
=20
+=09dl_se->dl_boosted=09=09=3D 0;
 =09dl_se->dl_throttled=09=09=3D 0;
 =09dl_se->dl_yielded=09=09=3D 0;
 =09dl_se->dl_non_contending=09=3D 0;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0db2c1b3361e..92444306fff7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -239,6 +239,7 @@ struct rt_bandwidth {
 =09unsigned int=09=09rt_period_active;
 };
=20
+void __dl_copy_static(struct task_struct *to, struct task_struct *from);
 void __dl_clear_params(struct task_struct *p);
=20
 /*
--=20
2.17.2

