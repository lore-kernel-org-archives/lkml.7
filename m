Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2230BC43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 01:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D927A2173E
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 01:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TpREVbDl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfLGBYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 20:24:32 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:42628 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfLGBYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 20:24:32 -0500
Received: by mail-pf1-f202.google.com with SMTP id s25so5042018pfd.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 17:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=I9mt7vf3xglkTwOGNx1fWAUc+1Y8ZQ1EzCG2Kz5JSK8=;
        b=TpREVbDlmbGdl7X6OdfnkSHz32jO7t2DNQu3Fk0+D7+tFK24KvQvFfF9w+lqpKVmE/
         HpShhZhO3ETyi9mCO8nAhgtoTsT113GqyU3oSlbOZpGcy8L/GcvI7DpFCKdZ1gd1DJyw
         y3Ruv7vwuBf/IGXuEW8S+frgmHuqzeGHxm48lqohulrB59uyw5ScqOW0lG1K8efbNIaD
         Ay7rWlhQXPGYCeI9Zix7wJm+nWZiGnme/vXqa/Ee0qJvlKC6doNI05HsPLQ7Gzpn6Szi
         kEWt3D9bQ6/E998uSbqWGXtVsCerryQPmSJ2YsRamOKM3MWxNiJKYyInXPWA+wtay1q/
         sIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=I9mt7vf3xglkTwOGNx1fWAUc+1Y8ZQ1EzCG2Kz5JSK8=;
        b=V32VCL3ktiuLvyQ+GaDFhjijzGbrsp5W7oUBlI6mXwAJ0pOFaSWC69pEC02ggvMfB5
         QBEFROVu+S1RRECuvWFjDdYCLutUQU+Ew4ujKwKIgGzCVyWU8Jxx1hu/K0l85O9glP5k
         lfKvjOBRGWSFIqLrNdkw16ml5q7wawJwHPu1ceL0IT3FP3CCeSVGr7dTI/qwq+bcihYZ
         1cvZ57zityXr+o6ex++oZPyXX+cN6n0By6GmDHKcUyvnFTtGclmO91LY5YYOuXDArY/S
         herafHjYH4QYIcTSY3cnZ6Kbe6/r6o7ENJznbYeZ5Dn7pvCMeka4IBoOupmaG4kc/PJn
         OrCQ==
X-Gm-Message-State: APjAAAVFnPp4NFIm1bTeSs6Af3lABQBxVYUeXBpMVkt1n8AveOrQhwIf
        SKaAj9d5jvZ8jZI+wKhnDXtn2hlhE1ToAFiqLg5sMw==
X-Google-Smtp-Source: APXvYqye9GJwzbmSJfQMzs/gTEW39cIotvIWty98XCfuzstgcfhNeQoBJIB2U0e+E7l62SaFjZY/+nW9N0M+gombP2pdOQ==
X-Received: by 2002:a63:4824:: with SMTP id v36mr6767662pga.343.1575681871642;
 Fri, 06 Dec 2019 17:24:31 -0800 (PST)
Date:   Fri,  6 Dec 2019 17:24:01 -0800
In-Reply-To: <20191016141312.15684-1-anton.ivanov@cambridgegreys.com>
Message-Id: <20191207012401.222282-1-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20191016141312.15684-1-anton.ivanov@cambridgegreys.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: Re: [PATCH] um: Add back support for extra userspace libraries
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc:     johannes.berg@intel.com, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> PCAP and VDE network transports require linking with userspace
> libraries. The current build system has no means of passing these
> as arguments.
>
> This patch adds a script to expand the library list for linking
> for these transports as well as any future driver that needs to
> rely on additional libraries on the userspace side.
>
> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
