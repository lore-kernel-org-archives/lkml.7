Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF881C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA6C206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URHFujMF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfLSOTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 09:19:32 -0500
Received: from mail-lf1-f45.google.com ([209.85.167.45]:44519 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfLSOTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 09:19:32 -0500
Received: by mail-lf1-f45.google.com with SMTP id v201so4448985lfa.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 06:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=Ork8StQMfTVuX32o3J7KQH8US/EDzzdCiRmJE8RfJBY=;
        b=URHFujMFr1oJ1RLGikF9aTCU3xHEYaZQX8j1Hjhtdn+f2YtC9q/phQZL8AvUVd4Hk0
         DNpzhv+ByT3w1TaWEyhIyJWTMDaXCnamNsUtfIH6LiFivdaVQPF30i7klNu7LmFPV8Lt
         VC6o1BoJS6GbElkhFWYE3tBBTxm5dFcNCmVZtUMYq/sD3SxG0v/aYwDWcDaBlWXoaXyF
         GN+3WSQ/nk1y8dCRFxrYS9xjxNaHiz4r/9O2s0jcXqfE9VAEykbQZlA+d8LvT1e4G9o9
         c3DIe0IzUU8XC3f0/ARiCa5XiswuAHCORmJrLXYXi3l//xd3rFFbh26hTK3wViGyrYJV
         xqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=Ork8StQMfTVuX32o3J7KQH8US/EDzzdCiRmJE8RfJBY=;
        b=p75s6s6kXdP/Jo/dlUV8nqmwRRkXqegk3DMyj3IGExL0VzZk83hHb8IjqJVJjxQZub
         tcsVlrJ/ZaLhBdZRZlluDZWjx40NxBpFp5PVPH4NSok6ty55K5Y4AvOQv4fk61D+Bcxe
         wmDPVn6dj0lnjOZVi/+mFFtDpUJLZetoD80tm3UF2JTjAezcDq77f4Rzd91R9aMSG4B+
         339lLXQx3gj2oAhj0j9UUyFeu7ZzY4EuObtJySj9Y8HqIbwLT5o6KFoXb5nEvUhgx58s
         lWXFklN2pkFqQMkTXYGsqNFCEmoQNPNSgVxprO4xdO5nL8BQYd3jN9PsU/CVVMwYKiUZ
         xxaQ==
X-Gm-Message-State: APjAAAXzCG2bzqN8njAnyJ1gigiJsWOAdkl3dTprqJN6NKJTzJvnoHWn
        9ZIf4RXkri5m8S/XYGx/38qhCCzNKzevJQ==
X-Google-Smtp-Source: APXvYqx+hCVlogKDGM50k+93eSlGJzWm8A6efIZ48yFykFdwV0mRzUKANU9HWvlNGvh7xmek/HrsYQ==
X-Received: by 2002:ac2:4422:: with SMTP id w2mr5572379lfl.178.1576765170264;
        Thu, 19 Dec 2019 06:19:30 -0800 (PST)
Received: from assa ([109.252.14.238])
        by smtp.gmail.com with ESMTPSA id n14sm2712984lfe.5.2019.12.19.06.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 06:19:29 -0800 (PST)
Date:   Thu, 19 Dec 2019 15:19:28 +0100
From:   Vitaly Wool <vitalywool@gmail.com>
To:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Streetman <ddstreet@ieee.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Henry Burns <henrywolfeburns@gmail.com>,
        Theodore Ts'o <tytso@thunk.org>
Subject: [PATCHv2 0/3] Allow ZRAM to use any zpool-compatible backend
Message-Id: <20191219151928.ad4ccf732b64b7f8a26116db@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The coming patchset is a new take on the old issue: ZRAM can currently be
used only with zsmalloc even though this may not be the optimal
combination for some configurations. The previous (unsuccessful) attempt
dates back to 2015 [1] and is notable for the heated discussions it has
caused.

This patchset addresses the increasing demand to deploy ZRAM in systems
where zsmalloc is not a perfect match or is not applicable at all. An
example of a system of the first type is an embedded system using ZRAM
block device as a swap where quick application launch is critical for
good user experience since z3fold is substantially faster on read than
zsmalloc [2].

A system of the second type would, for instance, be the one with
hardware on-the-fly RAM compression/decompression where the saved RAM
space could be used for ZRAM but would require a special allocator.
 
The preliminary results for this work have been delivered at Linux
Plumbers this year [3]. The talk at LPC ended in a consensus to continue
the work and pursue the goal of decoupling ZRAM from zsmalloc.

The current patchset has been stress tested on arm64 and x86_64 devices,
including the Dell laptop I'm writing this message on now, not to mention
several QEmu confugirations.

The first version of this patchset can be found at [4].
Changelog since V1:
* better formatting
* allocator backend is now configurable on a per-ZRAM device basis
* allocator backend is runtime configurable via sysfs 

[1] https://lkml.org/lkml/2015/9/14/356
[2] https://lkml.org/lkml/2019/10/21/743
[3] https://linuxplumbersconf.org/event/4/contributions/551/
[4] https://lkml.org/lkml/2019/10/10/1046
