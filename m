Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2003C10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 00:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B988C21473
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 00:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554770675;
	bh=D9o7/2X2RHKq7mi3dyJRuWHQu9HdlY306GvKQryYJM0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=gQrX/v5lhvuiiUbdrqszoIFmEmvpL3AyuKhKm4mbffrlRRNgzNaVlRWjy6+9KrvaR
	 ImwIyWHYITG1AUY+4SPo0rlKi6DDdvCEVRdTllLXV0HRIaqtrpnFavDkjvwHrdd+fQ
	 dv8Fqm9yXTNxW8LGaO3BehIxI2788SYNzF8axJLw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfDIAoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 20:44:34 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:55707 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726492AbfDIAoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 20:44:34 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 5FB162260D;
        Mon,  8 Apr 2019 20:44:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 08 Apr 2019 20:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=EY4KYpMSBgIrk8NdJ
        wqzmJTnkTcU/i4xZeqRBrgiees=; b=gLst+XeKCCqaf3IsWeI+xbalDj6B698Az
        OYtYRNSkL02AxiflJzZ9YMqxRaejpYxmkq677G02TsegzChcqHBCvwnRjDhlK0e7
        mtB9JglA90X7EoaEGgcotR0d0j88W18c8UBcmuoe8of4IVWFRKy6mVB/gfyPToZr
        6nXw1g9KI/KauWOq35xS8mprS2uXQaBNfDpkFPO00Gs5nejGgR3qZl4qWJ9U3RI6
        A3+6/1fUGxhfSjNO0aDq5W2/5Mys58ZE9sa2S3IMaYjk8WzG+1u2hT9mIZTjX45P
        CzMZB6R4cvvUtU6fctTR6N49P3ws5u+bKQfNo6Thoy5/LwpNWDrxw==
X-ME-Sender: <xms:8eqrXLzyKrRWj9Y28mk8O_vTUAy10xxFU7vPi_Vn4uVmzEGVyYvFzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudeggdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhnucev
    rdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkphepud
    dvuddrgeegrddvudejrdehtdenucfrrghrrghmpehmrghilhhfrhhomhepthhosghinhes
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:8eqrXIhVi9CDehuiuk6xMzBbfctqL0pZSJqduGNH3oc6sOH4D39_jQ>
    <xmx:8eqrXH_q1-eZsVtcijDDdZZxd2vCJXeNK5kdOvCOIPcQGedxHmg1gA>
    <xmx:8eqrXFMOeMS2i_YZDvKvXJzePUInPF1KXx-vSxG10C2MTCcynvDgIg>
    <xmx:8eqrXBH73oJmiaXJuW9TLcp4Kc_Jqq8NUbxYxE5CoG4bqtnmFuG8kQ>
Received: from eros.localdomain (ppp121-44-217-50.bras1.syd2.internode.on.net [121.44.217.50])
        by mail.messagingengine.com (Postfix) with ESMTPA id 49FF0E4519;
        Mon,  8 Apr 2019 20:44:31 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] docs: Fix various build warnings/errors
Date:   Tue,  9 Apr 2019 10:43:55 +1000
Message-Id: <20190409004359.29668-1-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

Here are the first 4 patches from the v1 of this series that are still
useful when applied to the current docs-next branch.

Set does a few minor clean ups, nothing too amazing here.  Patch 2
removes three Sphinx build warnings:

Patch 3 is slightly subjective, holla at me (anyone) if you don't like it
and I'll remove it.

thanks,
Tobin.


Tobin C. Harding (4):
  docs: Fix spelling mistake
  docs: Add colon clearing sphinx warning
  docs: Remove unnecessary reference link title
  docs: Use reference to link to rst file

 Documentation/admin-guide/mm/numa_memory_policy.rst | 9 ++++-----
 Documentation/process/howto.rst                     | 2 +-
 Documentation/vm/numa.rst                           | 4 ++--
 include/linux/wait.h                                | 2 +-
 4 files changed, 8 insertions(+), 9 deletions(-)

-- 
2.21.0

