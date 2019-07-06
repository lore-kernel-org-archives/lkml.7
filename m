Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9900DC0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 14:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5849A20856
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 14:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Y6b3AQKo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfGFOFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 10:05:39 -0400
Received: from mout.web.de ([212.227.15.3]:42377 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbfGFOFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 10:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1562421919;
        bh=C1ppvr7zqj47ZVQowy9V7V+DYD7yZg0Ynyd/2Vo5/DM=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=Y6b3AQKoiP3dpQ5yuK9nBeGjK//YqNdjqsx1BSzHvVKTu0RWtOnj/Pnqcor4MUgbE
         ICTcpAetDGAQN+EXZQKXK9+lZcupG4speHd4i3uYyXtnsGvBlcrNtTv/zvFowY3bKl
         tq77SjsBkJgc+lCH8xTzhbPU21hjqFS9f0qC9Q6s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.148.45]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LgYRZ-1iFmkU1yS5-00nzFh; Sat, 06
 Jul 2019 16:05:19 +0200
To:     kernel-janitors@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] sched/topology: One function call less in
 build_group_from_child_sched_domain()
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <ad2e7dfb-3323-b214-716e-a6cae41b8bcc@web.de>
Date:   Sat, 6 Jul 2019 16:05:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PPLYipWOeXoJMIecIppbe6rb4FHzVe4Ja4JIf7+IlTUuzfPFJMW
 yWJHv1KWR/CiPo0LUENxG7jmQqx14aQ6BCgzSdi2iSU3uYDSmuZ61HN1DpVkVf/5maRUPt4
 dLJr37OYRgpWmvn8YTIsI2v3bO5exhlRl5B5Zrvm0OrGW1s/FnRPX9V4mVW2BcaDJXA/NIN
 HdOSLvPjDc3iMo20dMi6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jLBiQOvwXBE=:3I6K0MsTz2K4UTbX+OgFOu
 uPEm3RBCyNbOIvLwo3toAUIy0YjxtuEb/OBqt7gOk63ApiY/+8Tr4ut8j4JEpFQARzFv6N8By
 TdkXt4AMy45us58QBUVrIC3E3mZfnFHF/8c1MQjXlzidaH473Y7ghqta64jXNvNPSs2CRJTyW
 TQ2ySdo+hCmilUvB0QfQz+6XL3wRKLZUQu4S5DjCkLR1+a1Vi6bd4UjCwZIhHAZ7LnzIEsi9i
 0CThKtFM7V8FT+sHYlWyBukn1K/ssqWnIDYAvzdh3qnmfUwec4wLH3BQaMCpNXhvJ95ipc4ze
 xce9iOuN2YJrIjG+NpI/zO0+ZdNwU2qmuqKPOa/sXbHjcrSnU3aegb0v63qNqYDVTgiuhyRYC
 11Uytf6l9/Gs/b7WvZIPlEPRzKTPxpratQNGht3SSwCtHHAJ8Lc3WOrBMAEewkAX9dIWKBvKr
 YiOMLhVVxn/Y2ZWGbyzBw+vbptb2BYEOeAbrJFXLf7QmI5a1U5MmBxamcgAGfPk08FBC3Amue
 aBfqWZl6XtLtL1aGZ0WHytaBjkxvDbl9e2LhFK8DatSMJyoLYztIkB0ZSN1CRO3QVm0B+kNwx
 6By+a0PCYepkBJozBTm4bANppntgLMmkTxigeoSAvR3KxEt/N24Hc9cpj4fucof228m+hfwcA
 hOK+sgzTpo6RjCNU9h8ODoMNJzDMqFOt03qje7rCUFefKX6bUDQGrblIrDCW0Uqoed2RhMl6e
 nxN9Kt56C4gh7zFoE+k6NI6vkH/qHJf2/W35SN/pJWBmue4vYsw0nm4/F37fCYOBSUVjK1Em+
 6Jmc9rrKO/q4XaZ20bdD0egYmLThBVDH/TeH804ocp2OWSZ/q/eRXIf513N902Hmeu1tiPm4d
 KOKTDMbWNnXRgoyaF7TvqtDjlcCzhGC8wQTs0knl2TYZys+kSTXcJuhYhsYXjnEvbNcZ6llRa
 T/RbCmENtti/IZCM8LZWRVSiaktXZ9FaaRQska1NHLVi05dqR1r++UrFckFUx7lD0a0gVZWXY
 ULCJblCrbp2OLBiTOrdWE/5vIxX6u/abpa6aEIniJOqFyQkuYbcNJqQ7j+PKbQr1HTd/QsaPL
 jjZho3hvQn5qnlR9HxZtwaWmvNZKvg30cnd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 6 Jul 2019 16:00:13 +0200

Avoid an extra function call by using a ternary operator instead of
a conditional statement.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 kernel/sched/topology.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index f751ce0b783e..6190eb52c30a 100644
=2D-- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -886,11 +886,7 @@ build_group_from_child_sched_domain(struct sched_doma=
in *sd, int cpu)
 		return NULL;

 	sg_span =3D sched_group_span(sg);
-	if (sd->child)
-		cpumask_copy(sg_span, sched_domain_span(sd->child));
-	else
-		cpumask_copy(sg_span, sched_domain_span(sd));
-
+	cpumask_copy(sg_span, sched_domain_span(sd->child ? sd->child : sd));
 	atomic_inc(&sg->ref);
 	return sg;
 }
=2D-
2.22.0

