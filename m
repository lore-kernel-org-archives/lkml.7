Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F02EC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3069E2077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NXPY98qG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730599AbfLKQbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:31:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52254 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729522AbfLKQbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 11:31:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7HvcTjE6EdC7yltRqiqqah/kodynClz3aRQRp8aRgEY=; b=NXPY98qGOhJENLSsyhO72Is0Y
        u65NujtGA75NJD/hJUO8HPitfwjN78pkQZCl6rXf3hC2VZkJabei+vzL4kYuiGPC7reyOc/oSYBT5
        Y3MeSG5+WuLGhQuBadXDWuXDJ0rY0O/Z6apD8vcXu+vkA7aZnzAOct1SzaEzhHJeNk2zOR11nFi3Y
        iBteCHssgklWW7Iw+7jF306zMWZPxJGHFk2N1XQbmrJO1jkT9Yw1vp29D9zHMTAVcLIKuVhgRRBES
        qJ9ujl/+gJtFN3bb0qpO9EOn1+vvVQuamvZ5i/ioT58HbniCfTNa8zYWIxq/PNag8W2YtTtvf1iPn
        37ERdQIRQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1if4tJ-0002Ac-BO; Wed, 11 Dec 2019 16:31:09 +0000
Subject: Re: mmotm 2019-12-10-19-14 uploaded (objtool: func() falls through)
To:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20191211031432.iyKVQ6m9n%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <07777464-b9d8-ff1d-41d9-f62cc44f09f3@infradead.org>
Date:   Wed, 11 Dec 2019 08:31:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191211031432.iyKVQ6m9n%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/19 7:14 PM, Andrew Morton wrote:
> The mm-of-the-moment snapshot 2019-12-10-19-14 has been uploaded to
> 
>    http://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> http://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.
> 
> You will need quilt to apply these patches to the latest Linus release (5.x
> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> http://ozlabs.org/~akpm/mmotm/series
> 
> The file broken-out.tar.gz contains two datestamp files: .DATE and
> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> followed by the base kernel version against which this patch series is to
> be applied.

on x86_64:

drivers/hwmon/f71882fg.o: warning: objtool: f71882fg_update_device() falls through to next function show_pwm_auto_point_temp_hyst()
drivers/ide/ide-probe.o: warning: objtool: hwif_register_devices() falls through to next function hwif_release_dev()
drivers/ide/ide-probe.o: warning: objtool: ide_host_remove() falls through to next function ide_disable_port()


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
