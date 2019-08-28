Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8084AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 508CD22CED
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtqnzLil"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfH1Ugc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 16:36:32 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41336 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfH1Ugc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 16:36:32 -0400
Received: by mail-qt1-f196.google.com with SMTP id i4so1105710qtj.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 13:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=azRAxHr0avIn2Bp0eJAD08hfKMaVL22jDWUPUYBHm4c=;
        b=jtqnzLil+XA7yTM3OdWgXVyNBavMUt5JAVUsgumaEP99csE94Haz1GwdZ7D5FHLeQ1
         W/TyJwZSzOAGiLwwZ505ytOCNFEqMu8n43sS52YeDrGxJhTUDH6KD3Ugx7gl3sK2QQWT
         kiOfLynt48kYhEChLre+4SNZA7AdaFkQEyvyITludBaSkM4bDyTMqbeBUb3//krnnXqh
         zuOiMZGjmb3bSEp8T9aW3PF6vPg8ZGkZ6+0PhlAAmB0vgAjhZnvcoa5xJOS37HJE0gQG
         ON80nJniur0DL+6O+fneIuz5W0L4UxOXA90L34eVs7tkcsh2eiwQuF013q+qZgOAx5kY
         ljJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=azRAxHr0avIn2Bp0eJAD08hfKMaVL22jDWUPUYBHm4c=;
        b=AfiipGZFM/3D5BotpMDV+dOfo2dfcgVwU6wB7EM3HyV05wSMQVnaHaWqdDR5CO9a0N
         Kg7/umvU1PV/Llq5ceYzig28J3MdQttbO9EMJgT0qf77u4DqZNa3G/svvpzU6xyaHE7+
         Ht+GDkuwjOAtOBfKmDBAcvoMBJeSuKqWwsZt0689xyzOZqu7c1nC6rIsgQTJbKOPLO1G
         HCBxk5Au4SEdDNrl0UZ+/JcQx1rPeq3Y9JyYSp3c+j9B0kLiPgOtfRmxUqRPVjdNeOJ3
         zrrCBvR6Vj01p9ncvb7/JSdGbFjDrbDvuG7OBrVlnQp5PWddgqyCwu5lod2DDOsnIsj1
         teQA==
X-Gm-Message-State: APjAAAWOEIeAaPwxX452BFr3yixQ2iHmjawgbsiLuJK2tqFf+7gHmZjp
        jErGVtjNUsErcVYZFxp/8es=
X-Google-Smtp-Source: APXvYqy6ZCNV6NVK5L14HO6HhqHQboRWbgBDDDbwB2gYO31bokexCtg+/WdPXMLE1wOY2xq4apS9bQ==
X-Received: by 2002:ac8:364a:: with SMTP id n10mr6632742qtb.148.1567024590924;
        Wed, 28 Aug 2019 13:36:30 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::b715])
        by smtp.gmail.com with ESMTPSA id h9sm126548qto.97.2019.08.28.13.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 13:36:30 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
To:     minyard@acm.org
Cc:     linux-kernel@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net, kernel-team@fb.com
Subject: [PATCH 0/1] Fix race in ipmi timer cleanup
Date:   Wed, 28 Aug 2019 16:36:24 -0400
Message-Id: <20190828203625.32093-1-Jes.Sorensen@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jes Sorensen <jsorensen@fb.com>

I came across this in 4.16, but I believe the bug is still present
in current 5.x, even if it is less likely to trigger.

Basially stop_timer_and_thread() only calls del_timer_sync() if
timer_running == true. However smi_mod_timer enables the timer before
setting timer_running = true.

I was able to reproduce this in 4.16 running the following on a host

   while :; do rmmod ipmi_si ; modprobe ipmi_si; done

while rebooting the BMC on it in parallel.

5.2 moves the error handling around and does it more centralized, but
relying on timer_running still seems dubious to me.

static void smi_mod_timer(struct smi_info *smi_info, unsigned long new_val)
{
        if (!smi_info->timer_can_start)
                return;
        smi_info->last_timeout_jiffies = jiffies;
        mod_timer(&smi_info->si_timer, new_val);
        smi_info->timer_running = true;
}

static inline void stop_timer_and_thread(struct smi_info *smi_info)
{
        if (smi_info->thread != NULL) {
                kthread_stop(smi_info->thread);
                smi_info->thread = NULL;
        }

        smi_info->timer_can_start = false;
        if (smi_info->timer_running)
                del_timer_sync(&smi_info->si_timer);
}

Cheers,
Jes

Jes Sorensen (1):
  ipmi_si_intf: Fix race in timer shutdown handling

 drivers/char/ipmi/ipmi_si_intf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
2.21.0

