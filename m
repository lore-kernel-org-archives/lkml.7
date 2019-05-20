Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6759C04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 22:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E782173C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 22:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Z5wz8Yrs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfETWsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 18:48:08 -0400
Received: from sonic305-9.consmr.mail.bf2.yahoo.com ([74.6.133.48]:37306 "EHLO
        sonic305-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726478AbfETWsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 18:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1558392485; bh=Zgj+p4WFZhNWb2yJwewxS8unIMB6qSZZhjmRqUgSubU=; h=From:Subject:To:Cc:Date:From:Subject; b=Z5wz8Yrs9vf1o6XI6afIGRfObCGtjgHZpd0mfzzJuu5VE4LzaRT+QFxTodxjNcW+QmXyOzlKmvJoemVNN9+8Uu7XqwBI8XI/W/B2fNy91+0lRWrHXPIIXcYSm0UAGJznM5uwAuPEsYjYW5J/eRzrTIIJLAZdFuOk6QGtjzmSpm+njy4kDrIDsPjjHHTyg+7P1LDYr8J08ywvVuyDNaS7JD6eVXJMObzdEbPbF7lKlTYQOK8aY9/1sje0+ST3HCG/sVoWMI2P0QBeyUiRjhEScELuhlldMg2bSVhZ444P1PZl9YN2gxKDAnLqpjERMthD1FETsKabCCMMbz0OssDPcA==
X-YMail-OSG: dt2imT8VM1m_K2dbb7Y5Rs3GooQRAWeNuJgmxzy5BwCyZXhrKbUUCgYPXRf4rIS
 S2aGOSi02Y2NblwV2FxtgE5gUxWH_OopPayV4ZAYrpxmOVGlA4oNgqeSXL6TSnrq.YtnFEllZwIF
 lcYCGKI2oxyOB7mfX3LnrQaHX_agmvKkOBz8qncEagzKjfS.0f6byMZNhzCLM4iGMF6ffJDzevjZ
 _vsvzNhuAhOgw7svlLnZns0_wU.JUXFvQXh_SGgWk1OtYQ8MxGDuUWylBkL4BMcdPDrGM1xHwKWf
 d3qqXlYUgA3.6OGLPJw7jYV3mHyIzuh6lfJNfdaDPuo_iOaiNMKvfEFG8eK8EZr405oFKFkFW.gY
 KBQQgXZZjQVdMs_6XT777E2ZgSLrgEBIKZNfUX3xKp7ab_ghXiU2VLUQUZJc75TNCcoC_L7OwkN1
 SbjRFnaI2giLm3wVQKIAdtoSUY_JokH7xqsgLqtwnN41OJctUFIpgcfzSYHT8JP.PpvbhFUtC7wZ
 Snjs6q3GTqp9TUOnNpEgS._3f1dbvJKxj4zm2lfl1m3.Vk_aLqyYE0yYq3laHRpLnVTjmg3RqA.H
 rf7txytMEhbfsP8MftUyQ8_YWN3GgWXvYcfWCvCXGoYoWUcxF_NBbeAnEmPvsRhAohk1G4umVNsy
 lJB17mQOWhw3WvQpkdwTvX6NNbMPnLafX8ukDl4gUlH8aX9fL0tQlL75go2ovJAk8Y10ItqOMFUw
 TTRmnIb_Ezqapu4FHGr9RNMPgRlLUHfYMlvrB4L3GRDic4Z8OnG2zL_D_ZxdZtQztlnSLJecxzHj
 1REPX0fp04hF1ZHhMcK0NCTC5wfk7vTkcNjgBCZ82NnTUAZ8k9Jy0O9ktxtVoIXMFRCS5wQYpqEp
 htVQAwYdHaLsWtLu1O.aqixOMcjYGucIcKrKA7_Oc868Rrd9Fo28XTedvNKBj.Cxi6jiN1jlisEg
 MWFW1ItVDoqt7XBEbCNGbd4nIxP7WLAqb2XC3uG3kzMSoZ3w6K1lnvO9o5aAc_LzXhmG9sulnCSh
 fpC3Tdjhy8ESfxR7bBomMeOd4qaCx73OCJJyupzBp0OkDtJoeX2ArytqR9362AeitUPzQFqkmQlx
 f4RnqPl2Uv3PuRQVoaZoYi0sUAUNLcSBQP5D8qnT9YdOHzvz.25PAYRoeJJ8._UwDvFcAX98uieU
 4zJLQwEFLBNijG_GpzjsNbZPnEANNiwE8M.U0QXv2H6._vDHadI8O_jJatgC24E0N05B1K6FtW.2
 Ut0c.cc_PcyvfySolg_0rYKocC0cSfBeL
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Mon, 20 May 2019 22:48:05 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp422.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b1610b935ff02ed2fe28a0e6d5cc8620;
          Mon, 20 May 2019 22:48:02 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH] Smack: Restore the smackfsdef mount option
To:     LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dhowells@redhat.com
Cc:     jose.bollo@iot.bzh, casey@schaufler-ca.com,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Message-ID: <1ebab7e7-f7ee-b910-9cc8-5d826eee8e97@schaufler-ca.com>
Date:   Mon, 20 May 2019 15:48:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 5.1 mount system rework changed the smackfsdef mount option
to smackfsdefault. This fixes the regression by making smackfsdef
treated the same way as smackfsdefault. The change was made in
commit c3300aaf95fb4 from Al Viro.

Reported-by: Jose Bollo <jose.bollo@iot.bzh>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
  security/smack/smack_lsm.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index b9abcdb36a73..915cf598e164 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -68,6 +68,7 @@ static struct {
  	int len;
  	int opt;
  } smk_mount_opts[] = {
+	{"smackfsdef", sizeof("smackfsdef") - 1, Opt_fsdefault},
  	A(fsdefault), A(fsfloor), A(fshat), A(fsroot), A(fstransmute)
  };
  #undef A
@@ -682,6 +683,7 @@ static int smack_fs_context_dup(struct fs_context *fc,
  }
  
  static const struct fs_parameter_spec smack_param_specs[] = {
+	fsparam_string("fsdef",		Opt_fsdefault),
  	fsparam_string("fsdefault",	Opt_fsdefault),
  	fsparam_string("fsfloor",	Opt_fsfloor),
  	fsparam_string("fshat",		Opt_fshat),

