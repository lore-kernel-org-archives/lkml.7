Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D81C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 22:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3C521738
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 22:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565131356;
	bh=EknRqymxoTJDoep6zXcHd2kEz6NOkgX5lpboEZyvK0A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=1IGieZo45tZxG9ARuGGA5uOEHEk3qI2Isk3SQSuLXbxBSxSR7k8KaaS7oEyG82ZCU
	 wVVPYlTaWKTrNlj487agxL1/gujc2JlRpjL5Tom7MpBhIOCZVYMtM3LpWuhRCU0ao0
	 vrLw6kEAnQJm8kcQTUUIyk10Q+Lre8eKjoQ/YWYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfHFWmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 18:42:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfHFWmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 18:42:35 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59715216F4;
        Tue,  6 Aug 2019 22:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565131354;
        bh=EknRqymxoTJDoep6zXcHd2kEz6NOkgX5lpboEZyvK0A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cRh0QGv3KwTTqbv+C7Ks/mBaeOIGhCJHLj3nOSKzHlIKAhpFAmN1MWab7DWF8nx8I
         WHnTV4WsnnbNtCgS8xeKytBXCWAIaXnnmy/UCklx3tamhutLFKYv1VtIrbLYJTnU7d
         YG5Jq9zrIGWI62RQa/qPahOdYTKYpqWdHbsu9V0s=
Date:   Tue, 6 Aug 2019 15:42:33 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     NeilBrown <neilb@suse.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Sergei Turchanov <turchanov@farpost.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seq_file: fix problem when seeking mid-record.
Message-Id: <20190806154233.5b16a91fd27c6cf129770566@linux-foundation.org>
In-Reply-To: <87mugojl0f.fsf@notabene.neil.brown.name>
References: <3bd775ab-9e31-c6b3-374e-7a9982a9a8cd@farpost.com>
        <5c4c0648-2a96-4132-9d22-91c22e7c7d4d@huawei.com>
        <eab812ef-ba79-11d6-0a4e-232872f0fcc4@farpost.com>
        <877e7xl029.fsf@notabene.neil.brown.name>
        <2d54ca59-9c22-0b75-3087-3718b30b8d11@farpost.com>
        <87mugojl0f.fsf@notabene.neil.brown.name>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Aug 2019 14:26:08 +1000 NeilBrown <neilb@suse.com> wrote:

> If you use lseek or similar (e.g. pread) to access
> a location in a seq_file file that is within a record,
> rather than at a record boundary, then the first read
> will return the remainder of the record, and the second
> read will return the whole of that same record (instead
> of the next record).
> Whnn seeking to a record boundary, the next record is
> correctly returned.

ouch.  I'm surprised it took this long to be noticed.

Maybe we need a seqfile-basher in tools/testing/selftests/proc or
somewhere.

