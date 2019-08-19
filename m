Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F565C41514
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC802070D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566225817;
	bh=mg7wpQqI+knk/uHjwLJFGO8j6H4IuCQ24kKaay86NeQ=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Z/t9GTcTdc6eAgVyU4yDnKsVMD/Wou8YY/SwXuyG/bQJOO7R0jmbV0RvmnScMzsQ5
	 ywygs1aNhkYvphCHdoVcVQZl54Wfgzy5PwvCrUISD7wsdDcuCnsCko2Jb/vNK/5v5/
	 yEQs/JPGu11vOmFpucwCjvSFzjJNxEfX3jHCdtKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfHSOng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:43:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbfHSOnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:43:31 -0400
Received: from [192.168.0.101] (unknown [180.111.132.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78FCE2070D;
        Mon, 19 Aug 2019 14:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566225811;
        bh=mg7wpQqI+knk/uHjwLJFGO8j6H4IuCQ24kKaay86NeQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gZtE/7L6ogJOIpE0DRbvf0ujK5r0mLjMBaDuX6EusC0a/MTVN0c0dTqDlkhtERkHH
         ++3CdRguWrr6gwE2szGk9m/bTR12uyWjiB8jECF/fkkO5PsV/xTSgmkGSlMCklsYY4
         jerBG5WCvu2u2QxU3hoEaU6t2S2PLdK3zvnqt7iE=
Subject: Re: [PATCH 2/6] staging: erofs: cannot set EROFS_V_Z_INITED_BIT if
 fill_inode_lazy fails
To:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
        Miao Xie <miaoxie@huawei.com>, weidu.du@huawei.com,
        Fang Wei <fangwei1@huawei.com>, stable@vger.kernel.org
References: <20190819080218.GA42231@138>
 <20190819103426.87579-1-gaoxiang25@huawei.com>
 <20190819103426.87579-3-gaoxiang25@huawei.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <22896e81-3474-2cc3-8023-744814f99549@kernel.org>
Date:   Mon, 19 Aug 2019 22:43:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190819103426.87579-3-gaoxiang25@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-8-19 18:34, Gao Xiang wrote:
> As reported by erofs-utils fuzzer, unsupported compressed
> clustersize will make fill_inode_lazy fail, for such case
> we cannot set EROFS_V_Z_INITED_BIT since we need return
> failure for each z_erofs_map_blocks_iter().
> 
> Fixes: 152a333a5895 ("staging: erofs: add compacted compression indexes support")
> Cc: <stable@vger.kernel.org> # 5.3+
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
