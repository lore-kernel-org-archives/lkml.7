Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B54CFC6195
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F0C20673
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573240299;
	bh=wFDjA2v+gkBrtrjNRPGQxKgCcRWFyG6N6sN3tvgirLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pGrU7Z3fDgjMg2pazgN05QqCKgVGPjMZ6oaiC04NxUY/p3L+Kgw9M415GPPN0J3E2
	 8PvOJxjvMc+m6AZ/l8CKibR5/8hFmVFIk3ff2Y5Z79CvHB5HstiRcx0Tj57LPQotAg
	 oYzZ2Rzg/org35xTB6kaXcSMJplD4qvvYda/AcZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390459AbfKHTLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:11:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:42974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391909AbfKHTKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:10:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F149A21D82;
        Fri,  8 Nov 2019 19:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573240241;
        bh=wFDjA2v+gkBrtrjNRPGQxKgCcRWFyG6N6sN3tvgirLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IXjOXs1hwqKIN6relhV2UrQdj871sGLCjFhz4qHBY/eRe7X7vBVXQoqh4CsnaR6DK
         X7T3KO7ob6uTQ4E5tbpFiz7hagZkpN1+0aF/BbukizmzeTbt0jkyKWTar2czBPAHFr
         F3UhloW+yRsySn3lBFelGPz8NgOkQDAuH/OJAZVU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Desnes A. Nunes do Rosario" <desnesn@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sandipan Das <sandipan@linux.ibm.com>
Subject: [PATCH 5.3 137/140] selftests/powerpc: Fix compile error on tlbie_test due to newer gcc
Date:   Fri,  8 Nov 2019 19:51:05 +0100
Message-Id: <20191108174913.209758721@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174900.189064908@linuxfoundation.org>
References: <20191108174900.189064908@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Desnes A. Nunes do Rosario <desnesn@linux.ibm.com>

commit 5b216ea1c40cf06eead15054c70e238c9bd4729e upstream.

Newer versions of GCC (>= 9) demand that the size of the string to be
copied must be explicitly smaller than the size of the destination.
Thus, the NULL char has to be taken into account on strncpy.

This will avoid the following compiling error:

  tlbie_test.c: In function 'main':
  tlbie_test.c:639:4: error: 'strncpy' specified bound 100 equals destination size
      strncpy(logdir, optarg, LOGDIR_NAME_SIZE);
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors

Signed-off-by: Desnes A. Nunes do Rosario <desnesn@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20191003211010.9711-1-desnesn@linux.ibm.com
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/powerpc/mm/tlbie_test.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/selftests/powerpc/mm/tlbie_test.c
+++ b/tools/testing/selftests/powerpc/mm/tlbie_test.c
@@ -636,7 +636,7 @@ int main(int argc, char *argv[])
 			nrthreads = strtoul(optarg, NULL, 10);
 			break;
 		case 'l':
-			strncpy(logdir, optarg, LOGDIR_NAME_SIZE);
+			strncpy(logdir, optarg, LOGDIR_NAME_SIZE - 1);
 			break;
 		case 't':
 			run_time = strtoul(optarg, NULL, 10);


