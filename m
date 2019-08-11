Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AA8C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 18:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625962084C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 18:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAUesqdC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbfHKSq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 14:46:26 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35185 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfHKSq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 14:46:26 -0400
Received: by mail-lj1-f196.google.com with SMTP id l14so6506189lje.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 11:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=G0DOFHA8eVoNDoQdcja02y/muQPflx5tBcQTBpoDNTE=;
        b=DAUesqdCL/UDY5CBh48z8ZaXw12W2P3pXntHhwx0odgZ90g6ku9enum8kXMj7Jl801
         6xIuICl2jKUK2CGqqzqvsRbGp+woveSHR3StSkXSDyDHQCIzVSzV8tHX6r0x6QDuFA0p
         Tl5Ah3Ss0AWssXrSPISLfUk9BBDGMPA3wAT7nOMeIgs58B/zPC20CleNlmJhCXn7wgVJ
         DrFos1G+JBSvRaUHW9/cc5JiRZM39+vJ3ZMX0w0oygqknabbOEtTYE9TabDNyOWfSEqR
         JCfZeImwzo+h/mwkX6uyWEJOlm6djgasegJGuUyydgrRvAcSA/GK/NLut58O+o10DMt6
         0Iqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G0DOFHA8eVoNDoQdcja02y/muQPflx5tBcQTBpoDNTE=;
        b=O4YbVVOJx2MWjNnKXY2K4LkSYVb795sYaWvyNhg9wqrER+s4yRgCnyDDVqYshyd8pc
         fefU1RB7AVsHMnTS+REgWXrWV9X+hWL6/OV71TZr4ZLGptpKhyxAALlw57ezm811JyN2
         y7EZ1BJhBAHH1jCBb10z5XkOq2Uambia4LQpWy056SLetFsS/vQmFj5nar+nCgLlAbAn
         jDLNN730Fv/ajTPfbdx+VmDWZbq2jnzpmV8VqenjNyCAo3+O5fzGXQ3fpA66Nxe6lxY4
         iIOu4JxmN3HuK/kAG7KbBQknJAQeV93xIm6RxXkGGT17oqRCrOm8IvZtRnADgKK6nUQ9
         ScMA==
X-Gm-Message-State: APjAAAWKG/QkdyBD1oZASk7+AczbS8tFKQ0XRgyE5i16vDmloteR3gJr
        vNjjp6ecPDyQmPqib42DUT/2ywB+kf3PEA==
X-Google-Smtp-Source: APXvYqyOYshbyWaswvLHHrzMXwMcaMRcuzVh2HZZb8c59GFe9C/ObyM7Ivv5RE7+z4NEjvweWWKjmw==
X-Received: by 2002:a2e:9889:: with SMTP id b9mr7541875ljj.230.1565549183913;
        Sun, 11 Aug 2019 11:46:23 -0700 (PDT)
Received: from localhost.localdomain ([37.212.199.11])
        by smtp.gmail.com with ESMTPSA id t66sm1536425lje.66.2019.08.11.11.46.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 11:46:23 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken@google.com>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 0/2] some cleanups related to RB_DECLARE_CALLBACKS_MAX
Date:   Sun, 11 Aug 2019 20:46:11 +0200
Message-Id: <20190811184613.20463-1-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently we have got RB_DECLARE_CALLBACKS_MAX template that is supposed
to be used in case of having an augmented value as scalar value. First
patch just simplifies the *_compute_max() callback by using max3()
macro that makes the code more transparent, i think. No functional changes.

Second patch reuses RB_DECLARE_CALLBACKS_MAX template's internal functionality,
that is generated to manage augment red-black tree instead of using our own and
the same logic in vmalloc. Just get rid of duplication. No functional changes.

Also i have open question related to validating of the augment tree, i mean
in case of debugging to check that nodes are maintained correctly. Please
have a look here: https://lkml.org/lkml/2019/7/29/304

Basically we can add one more function under RB_DECLARE_CALLBACKS_MAX template
making it public that checks a tree and its augmented nodes. At least i see
two users where it can be used: vmalloc and lib/rbtree_test.c.

Appreciate for any comments.

Uladzislau Rezki (Sony) (2):
  augmented rbtree: use max3() in the *_compute_max() function
  mm/vmalloc: use generated callback to populate subtree_max_size

 include/linux/rbtree_augmented.h       | 40 +++++++++++++++++-----------------
 mm/vmalloc.c                           | 31 +-------------------------
 tools/include/linux/rbtree_augmented.h | 40 +++++++++++++++++-----------------
 3 files changed, 41 insertions(+), 70 deletions(-)

-- 
2.11.0

