Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6F1C48BE0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98FD22075E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561130895;
	bh=SxgDdvhUv1xb65UNG7ruN5SCQZQm70r6jjkw1BEIw+E=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=oF4kJ+uUHX8ShvMSx52bjDlDQB5J/XYvHB2D0Qr08Aa1IuAsPK8I/bZLvSgE2FTtQ
	 xWYbNKhVItN0HVJaCtlXzPUse7r1/bwCxZDrn7rkyilGtzXKXiraGBqfHoxqJhV2Zh
	 qv3tmKY1PK618oOgPZJB44U+RUc5XZEHHJ/RrLT4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfFUP2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 11:28:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53294 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfFUP2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 11:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Be/MzKSNe3fAjFm8bS597mD7hGn/oAppHYPoJ6iD6gA=; b=e0zJob7d2mhL2Pdyssnl46dzP
        1uY6uynfUbsnUb0y/0wjEeX6XH+LZcU5JsZVpp9U1KQyqkGodRRvM0Frc7Zg9M/6ku30giVLrv1QI
        xSuIAUQH4poHkPWbPu3YYipODeLp3DZ3CL2I/917p/Wh6G9nFSfQCvHaedMRMTCBFsZi/jSVgKSyP
        tjzgSTKfG9fDsxF7fqsmaLQ8txCRulLqPVKcxwcClhfCEqsfM+OtKubtOHdZQKDoqGIjybKBba3Ij
        M8VK0022EItpF9O7Ptf0B1GmzayE3Y4y9W/J+DDQgxu+8A381SbzEpp5Qx8OqCEgkS3ns8G0R5VTt
        2kAaqPghQ==;
Received: from [177.97.20.138] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1heLSR-0006At-KA; Fri, 21 Jun 2019 15:28:07 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1heLSO-0005i8-Hd; Fri, 21 Jun 2019 12:28:04 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        gregkh@linuxfoundation.org
Subject: [PATCH 0/2] Report warnings to the file they belong
Date:   Fri, 21 Jun 2019 12:28:00 -0300
Message-Id: <cover.1561130657.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reporting an ABI error to the get_abi.pl script is not nice, as it
doesn't maky any easy to fix it.

Instead, just like with kernel-doc, put the fingers to the files
that didn't parse ok:


    Documentation/ABI/testing/sysfs-kernel-mm-hugepages:3: WARNING: Definition list ends without a blank line; unexpected unindent.
    Documentation/ABI/testing/evm:4: ERROR: Unexpected indentation.
    Documentation/ABI/testing/evm:3: WARNING: Block quote ends without a blank line; unexpected unindent.

---

Greg,

Independently of the RFC patches, I would apply those two ones
together with the script, as they make a lot easier to debug
issues.

Mauro Carvalho Chehab (2):
  get_abi.pl: Allow optionally record from where a line came from
  docs: kernel_abi.py: use --enable-lineno for get_abi.pl

 Documentation/sphinx/kernel_abi.py | 18 ++++++++++++++----
 scripts/get_abi.pl                 | 21 ++++++++++++++++++++-
 2 files changed, 34 insertions(+), 5 deletions(-)

-- 
2.21.0


