Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1EDC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14AFB21841
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639487;
	bh=hnyuKlwcGnhqMmJ0G7Kl+bjhhI1ODqP4u/lCpUileYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RTQ0Hdr1TLZBHSYzdCx8OHxQs83n4l0/uJHHtOAXdGVVzy+gXEZ4bvbksFL1HkEP4
	 4puAvKJsMUTQimcsYWRZ7Hf8W+vHkJakixldfPOIHZdJSgvWG1s3a/KOyMWrcU0hWK
	 J7xPilmMbWjqw0zEPYzWH9lwRgKBclMw6HK0ViRk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390975AbfEWTYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:24:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:35740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390545AbfEWTYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:24:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBF722054F;
        Thu, 23 May 2019 19:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639481;
        bh=hnyuKlwcGnhqMmJ0G7Kl+bjhhI1ODqP4u/lCpUileYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w43PHblHTvoOnz/84uDWJo7YuvUsy+kL2Zhjha1XRQJHNcvvC5KQTZe0tUkCmmVUH
         x8xTZ3lzOcYEzjXaVvO7d5oOfkBSDcbVy5TZutumaTaxDEUO6rrFvXbiJ+NXuTbD+3
         JyfrFIR97e+om7xlPKWKNnnNxGZ9Cdn11ur3+Rh4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alban Crequy <alban@kinvolk.io>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Song Liu <songliubraving@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 121/139] tools: bpftool: fix infinite loop in map create
Date:   Thu, 23 May 2019 21:06:49 +0200
Message-Id: <20190523181735.320430804@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181720.120897565@linuxfoundation.org>
References: <20190523181720.120897565@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 8694d8c1f82cccec9380e0d3720b84eee315dfb7 ]

"bpftool map create" has an infinite loop on "while (argc)". The error
case is missing.

Symptoms: when forgetting to type the keyword 'type' in front of 'hash':
$ sudo bpftool map create /sys/fs/bpf/dir/foobar hash key 8 value 8 entries 128
(infinite loop, taking all the CPU)
^C

After the patch:
$ sudo bpftool map create /sys/fs/bpf/dir/foobar hash key 8 value 8 entries 128
Error: unknown arg hash

Fixes: 0b592b5a01be ("tools: bpftool: add map create command")
Signed-off-by: Alban Crequy <alban@kinvolk.io>
Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
Acked-by: Song Liu <songliubraving@fb.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/map.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 1ef1ee2280a28..227766d9f43b1 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -1111,6 +1111,9 @@ static int do_create(int argc, char **argv)
 				return -1;
 			}
 			NEXT_ARG();
+		} else {
+			p_err("unknown arg %s", *argv);
+			return -1;
 		}
 	}
 
-- 
2.20.1



