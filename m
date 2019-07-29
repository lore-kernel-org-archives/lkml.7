Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7030C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 03:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0222075B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 03:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ya4JdOTt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfG2DyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 23:54:07 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:32885 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfG2DyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 23:54:06 -0400
Received: by mail-pf1-f169.google.com with SMTP id g2so27276669pfq.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 20:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=8PRy5r0RLK0DMjkOaMUsvRFz+2ENwpqQIfeTXdyxYK0=;
        b=Ya4JdOTtk+x6/WCvUjb2tHR2eBqA9nEE7GaNgrR9Cvp3n4aNQiBKTO/KUreWTbnn+I
         MTw4x1ddRkXHwAKdh8LnjiCPvxOcHgL+YAZPVlKrrtTOjqXGQpGyJmbSiojE4I3VeEsJ
         XFdtruFZadpL1WH+7cgoJoaEDiYNoHjhklqRZ2XXh7sNfA/aD3hmU63YIU76FHfEWGTW
         NRAga2YcRMPVlu8PRBmHMG/aMnb571NUgr/oUgLjVDwinjlx57p8GKlm0NtElrS8G8dd
         GeIDFa6sNLkG5/q22rnueLxVheiqt9kPwgzU1SScz5K3Xg3PCNUz5Ulst/Ob3zmUqgSh
         8/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=8PRy5r0RLK0DMjkOaMUsvRFz+2ENwpqQIfeTXdyxYK0=;
        b=ZDzYGzRIzpzVh6b1MrKWwn5gy3Gya/Wi7EKwA0lj4poRg9nEn1gRffLT2paIoN+tUf
         M90xB2lg4xCDVJvFB7yWsLv2+RROUOYEOMRUz8sj/C7R7itYPYJbtjzeGKLRDJ1gulqO
         +P5RVXsTAGa+IU5V10UWPRT8mnBnk2B4nSejNkMkkFgfN7bA6HwCBSSucTD/gNhff6I0
         XRwjKj9MtzaE8FEcors8il14nv1DZZAqt/4F4I8Hxe/nN2nVM52I9PoWOoGwrh4sagAy
         BZQSVXZdkPuzg14QN75mzDWclGNh1Vbgbwg+a0n606F8BMHWwagdbeeJyilOOKPNMMAt
         vm3w==
X-Gm-Message-State: APjAAAW+yzWC79RT9maXEcxYq/dHNWF+buiLPUGoHWggOnHq39QQWGzW
        95+VcPeM7PVzdoAH6qX1EVRyeRcCrVw=
X-Google-Smtp-Source: APXvYqzaSZlyNwojCKSRH77jCfkI7OwlkitSUcLjmx4okU8a8s+2C+PeVVqlmMNMzjcULr3fyy8JsQ==
X-Received: by 2002:a65:5183:: with SMTP id h3mr9557074pgq.250.1564372446085;
        Sun, 28 Jul 2019 20:54:06 -0700 (PDT)
Received: from ?IPv6:2402:f000:4:72:808::177e? ([2402:f000:4:72:808::177e])
        by smtp.gmail.com with ESMTPSA id p26sm5438031pgl.64.2019.07.28.20.54.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2019 20:54:05 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] ALSA: core: seq: a possible double-lock bug in
 snd_seq_midisynth_remove()
To:     perex@perex.cz, Takashi Iwai <tiwai@suse.de>,
        gregkh@linuxfoundation.org, rfontana@redhat.com,
        allison@lohutok.net, tglx@linutronix.de
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Message-ID: <50b3b4c4-fe36-8c65-345b-f0a51193726c@gmail.com>
Date:   Mon, 29 Jul 2019 11:54:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In snd_seq_midisynth_remove(), there is a possible double-lock bug:
snd_seq_midisynth_remove()
     mutex_lock(&register_mutex); -- line 421
     snd_seq_delete_kernel_client() --- line 436
         seq_free_client() -- line 2244
             mutex_lock(&register_mutex); -- line 294

This bug is found by a static analysis tool STCheck written by us.

I do not know how to correctly fix this bug, so I only report it.
A possible fix is to release the mutex lock before calling 
seq_free_client() in snd_seq_delete_kernel_client() and then acquiring 
the lock again after calling seq_free_client().


Best wishes,
Jia-Ju Bai
