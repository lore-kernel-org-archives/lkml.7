Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBA5C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF0A206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555964526;
	bh=8SDBOoU6iDWbmlGqsA0QIbropWgQ0wcQuI8T2DvImZM=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=O8Pr3Xx9yBkgkobfRzltWB+Kot0YECOqIeQiRImjUelSYUXpPNdbAk/vOvT7rggPP
	 a0Y7o6DKomtDSOeAeWYAUxih+7rohBUMdn5ucXR/Yv8s0zy82J/Dr0kMJqvaR7l7Mq
	 m2ywyUjxoZ6bZy12bk9jgKsC32WuBmZY8nKeLEi8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbfDVUWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:22:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727190AbfDVUWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 16:22:03 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74B4B20693;
        Mon, 22 Apr 2019 20:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555964522;
        bh=8SDBOoU6iDWbmlGqsA0QIbropWgQ0wcQuI8T2DvImZM=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=nNs0xAvsVfVUdsyEhBpsZvn6qrlUBnBWPfwUKGBDokBXdLoqU3ypNNlZ+06tCbGVN
         wWG2MbqgsmgBBfD2CKOfJwmji9j91JI94G2P0cxDOY6KBw2N0U7dvRO7ZJgPDF9KVn
         OSb8yj9ws0agEv8fBOdZhyL+isHYfpOkbMgXkn1s=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ab7b65d29dbd7623c679c4ef91352d594a24f39a.1555921081.git.leonard.crestez@nxp.com>
References: <cover.1555921081.git.leonard.crestez@nxp.com> <ab7b65d29dbd7623c679c4ef91352d594a24f39a.1555921081.git.leonard.crestez@nxp.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 2/3] scripts/gdb: Initial clk support: lx-clk-summary
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Message-ID: <155596452161.15276.15842111427229300135@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Mon, 22 Apr 2019 13:22:01 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Leonard Crestez (2019-04-22 01:26:57)
> +
> +
> +class LxClkSummary(gdb.Command):
> +    """Print Linux kernel log buffer."""

This comment needs an update.

> +
> +    def __init__(self):
> +        super(LxClkSummary, self).__init__("lx-clk-summary", gdb.COMMAND=
_DATA)
> +
> +    def show_subtree(self, clk, level):
> +        gdb.write("%*s%-*s %7d %8d %8d\n" % (
> +                level * 3 + 1, "",
> +                30 - level * 3,
> +                clk['name'].string(),
> +                clk['enable_count'],
> +                clk['prepare_count'],
> +                clk['protect_count']))

Would be nice to also print the rate, phase, etc. It's all pretty much
there already so it's just dumping data out. If it's a clk that has
CLK_GET_RATE_NOCACHE then I guess we have to print out '<unknown>'
because it relies on runtime code execution.

> +
> +        for child in clk_core_for_each_child(clk['children']):
> +            self.show_subtree(child, level + 1)
