Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C18FC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 597232146F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555015336;
	bh=eDElxih9zBKhayq8q0iHrybWnG2bEC3whDfJAjheOQk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ah4EQNpEZ5kFFtHvJj/Osw3WbOcZuEDYF125FdcnaiiLSpTnz2hOaSWvyV/rx0aV8
	 D3KItpVo7iamwW2t/iU0aujjB8A8vwCdqseICA2T2TCLeaIscYvWd+6Z4blIVaK3z5
	 TMJW5GpDC7828Qs04DLQZzPVzfWPLl/p1sjSaj64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfDKUmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:42:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726655AbfDKUmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 16:42:14 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D75B62146F;
        Thu, 11 Apr 2019 20:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555015334;
        bh=eDElxih9zBKhayq8q0iHrybWnG2bEC3whDfJAjheOQk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hW2C1Da662NiUUMR7RXwdTlB+oVby/s9jYOfT19+HZKiMvZKRy46Mf3swzoQw7r5T
         pk/392CaEU3/EMaZe6PctzGV/8/uErbVrGQ8b44xLnl5vFZ0LKk7JIjQD8mwO1kdKM
         LJM5aEd3PZ/le10YlvBA4nAuaDPtCIIQzOWmfrVM=
Received: by mail-ed1-f50.google.com with SMTP id d13so6434139edr.5;
        Thu, 11 Apr 2019 13:42:13 -0700 (PDT)
X-Gm-Message-State: APjAAAVd+64t+bDlRCESnkqi0c8q5SSAadXTl9tvDOowe6jAvxQmAMvb
        Wz/exVzG6SVgdLKePz4bRlYZKhlK0x2/qe4qGLA=
X-Google-Smtp-Source: APXvYqzU9T2gwNvY+HquzuQ6qgYhh92N+lCBbXOCVcFiM0WJz/cVpKXOVWu5kMDsU6vxqz4qB2eG/USW5eSadImuEzk=
X-Received: by 2002:a17:906:25ce:: with SMTP id n14mr20450002ejb.115.1555015332479;
 Thu, 11 Apr 2019 13:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <1553483264-5379-1-git-send-email-hao.wu@intel.com>
 <1553483264-5379-13-git-send-email-hao.wu@intel.com> <20190402150719.GB15773@archbook>
In-Reply-To: <20190402150719.GB15773@archbook>
From:   Alan Tull <atull@kernel.org>
Date:   Thu, 11 Apr 2019 15:41:36 -0500
X-Gmail-Original-Message-ID: <CANk1AXQdFy9c7i54zk4yqzqK-vxm009bXKrgvyCR64h3rDwwRA@mail.gmail.com>
Message-ID: <CANk1AXQdFy9c7i54zk4yqzqK-vxm009bXKrgvyCR64h3rDwwRA@mail.gmail.com>
Subject: Re: [PATCH 12/17] fpga: dfl: afu: add STP (SignalTap) support
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Wu Hao <hao.wu@intel.com>, Alan Tull <atull@kernel.org>,
        linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 2, 2019 at 10:07 AM Moritz Fischer <mdf@kernel.org> wrote:
>
> Hi Wu,
>
> On Mon, Mar 25, 2019 at 11:07:39AM +0800, Wu Hao wrote:
> > STP (SignalTap) is one of the private features under the port for
> > debugging. This patch adds private feature driver support for it
> > to allow userspace applications to mmap related mmio region and
> > provide STP service.
> >
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> Acked-by: Moritz Fischer <mdf@kernel.org>

Acked-by: Alan Tull <atull@kernel.org>

Thanks,
Alan
