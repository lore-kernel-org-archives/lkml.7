Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F117C76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 19:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE257218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 19:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564084555;
	bh=GUDXTHSL/kqp7YkB83rQQbP5rhs1Z4lmyoyGQWtFZuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W/rlSnat2ve8dAgcuCx73iz9TtLXs2cj6VyYyvZiHWbikVp0h4Kq+iAHZu4a4+JWu
	 HtarQMOWY/RZYyx4DytEHYbXRYhv1aE/vNTJ1mP2DRrOc4Y8jN2vhqsqDXywyZc6W+
	 d3UahnirUVTmbgp3Ad1j36QLCrbxB9Fdap5Ok7Lc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfGYTzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 15:55:53 -0400
Received: from mga03.intel.com ([134.134.136.65]:56504 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfGYTzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 15:55:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 12:55:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,307,1559545200"; 
   d="scan'208";a="171944447"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga007.fm.intel.com with ESMTP; 25 Jul 2019 12:55:51 -0700
Date:   Thu, 25 Jul 2019 13:52:59 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Busch, Keith" <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
Message-ID: <20190725195258.GA7307@localhost.localdomain>
References: <2332799.izEFUvJP67@kreacher>
 <20190725145209.GA6949@localhost.localdomain>
 <2428826.VBuqOhikiK@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2428826.VBuqOhikiK@kreacher>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 09:48:57PM +0200, Rafael J. Wysocki wrote:
> NVME Identify Controller:
> vid     : 0x1c5c
> ssvid   : 0x1c5c
> sn      : MS92N171312902J0N   
> mn      : PC401 NVMe SK hynix 256GB               
> fr      : 80007E00
> rab     : 2
> ieee    : ace42e
> cmic    : 0
> mdts    : 5
> cntlid  : 1
> ver     : 10200
> rtd3r   : 7a120
> rtd3e   : 1e8480
> oaes    : 0x200
> ctratt  : 0
> oacs    : 0x17
> acl     : 7
> aerl    : 3
> frmw    : 0x14
> lpa     : 0x2
> elpe    : 255
> npss    : 4
> avscc   : 0x1
> apsta   : 0x1
> wctemp  : 352
> cctemp  : 354
> mtfa    : 0
> hmpre   : 0
> hmmin   : 0
> tnvmcap : 0
> unvmcap : 0
> rpmbs   : 0
> edstt   : 10
> dsto    : 0
> fwug    : 0
> kas     : 0
> hctma   : 0
> mntmt   : 0
> mxtmt   : 0
> sanicap : 0
> hmminds : 0
> hmmaxd  : 0
> nsetidmax : 0
> anatt   : 0
> anacap  : 0
> anagrpmax : 0
> nanagrpid : 0
> sqes    : 0x66
> cqes    : 0x44
> maxcmd  : 0
> nn      : 1
> oncs    : 0x1f
> fuses   : 0x1
> fna     : 0
> vwc     : 0x1
> awun    : 7
> awupf   : 7
> nvscc   : 1
> acwu    : 7
> sgls    : 0
> mnan    : 0
> subnqn  : 
> ioccsz  : 0
> iorcsz  : 0
> icdoff  : 0
> ctrattr : 0
> msdbd   : 0
> ps    0 : mp:6.00W operational enlat:5 exlat:5 rrt:0 rrl:0
>           rwt:0 rwl:0 idle_power:- active_power:-
> ps    1 : mp:3.80W operational enlat:30 exlat:30 rrt:1 rrl:1
>           rwt:1 rwl:1 idle_power:- active_power:-
> ps    2 : mp:2.40W operational enlat:100 exlat:100 rrt:2 rrl:2
>           rwt:2 rwl:2 idle_power:- active_power:-
> ps    3 : mp:0.0700W non-operational enlat:1000 exlat:1000 rrt:3 rrl:3
>           rwt:3 rwl:3 idle_power:- active_power:-
> ps    4 : mp:0.0070W non-operational enlat:1000 exlat:5000 rrt:3 rrl:3
>           rwt:3 rwl:3 idle_power:- active_power:-

Hm, nothing stands out as something we can use to determine if we should
skip the nvme specific settings or allow D3. I've no other ideas at the
moment for what we may check.
