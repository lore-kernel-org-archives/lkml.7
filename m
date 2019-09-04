Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533AFC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 271D821726
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567617379;
	bh=s/4Q139w6ZtV2vYIxV2peDGPht9UxS9f66jJsdORCsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bS+gzMFelTR8lOcZg0FbvY0Gs59JAu6y88rFQBkH2IqlapuydoV0TqhxHwH538iji
	 45Ic6RbOkD3p7dTFO6kQsrWvsO9zATfKv3eecWNH4U68MJyJC4dj7HZU7S3IhAxPPv
	 BZbTD1hwTzBNKM/tq9IQvoaEVjlcf9g1EKKQ4ZzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731813AbfIDRQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 13:16:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:25282 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731173AbfIDRQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 13:16:17 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 10:16:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,467,1559545200"; 
   d="scan'208";a="212470355"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga002.fm.intel.com with ESMTP; 04 Sep 2019 10:16:16 -0700
Date:   Wed, 4 Sep 2019 11:14:45 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH] nvme-core: Fix subsystem instance mismatches
Message-ID: <20190904171445.GG21302@localhost.localdomain>
References: <20190831152910.GA29439@localhost.localdomain>
 <33af4d94-9f6d-9baa-01fa-0f75ccee263e@deltatee.com>
 <20190903164620.GA20847@localhost.localdomain>
 <20190904060558.GA10849@lst.de>
 <20190904144426.GB21302@localhost.localdomain>
 <20190904154215.GA20422@lst.de>
 <20190904155445.GD21302@localhost.localdomain>
 <ef3bf93b-cb47-95c5-7d96-f81d9acfdb55@deltatee.com>
 <20190904163557.GF21302@localhost.localdomain>
 <f07e03f1-48f0-591e-fdf6-9499fa4dd9ab@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f07e03f1-48f0-591e-fdf6-9499fa4dd9ab@deltatee.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 11:01:22AM -0600, Logan Gunthorpe wrote:
> Oh, yes that's simpler than the struct/kref method and looks like it
> will accomplish the same thing. I did some brief testing with it and it
> seems to work for me (though I don't have any subsystems with multiple
> controllers). If you want to make a patch out of it you can add my
>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks! I'll make it a proper patch and send shortly.

For testing multi-controller subsystems, I haven't got proper hardware
either, so I really like the nvme loop target. Here's a very simple json
defining a two namespace subsystem backed by two real nvme devices:

loop.json:
---
{
  "ports": [
    {
      "addr": {
        "adrfam": "",
        "traddr": "",
        "treq": "not specified",
        "trsvcid": "",
        "trtype": "loop"
      },
      "portid": 1,
      "referrals": [],
      "subsystems": [
        "testnqn"
      ]
    }
  ],
  "subsystems": [
    {
      "attr": {
        "allow_any_host": "1"
      },
      "namespaces": [
        {
          "device": {
            "nguid": "ef90689c-6c46-d44c-89c1-4067801309a8",
            "path": "/dev/nvme0n1"
          },
          "enable": 1,
          "nsid": 1
        },
        {
          "device": {
            "nguid": "ef90689c-6c46-d44c-89c1-4067801309a9",
            "path": "/dev/nvme1n1"
          },
          "enable": 1,
          "nsid": 2
        }
      ],
      "nqn": "testnqn"
    }
  ]
}
--

Configure the target:

  # nvmetcli restore loop.json

Connect to it twice:

  # nvme connect -n testnqn -t loop
  # nvme connect -n testnqn -t loop

List the result:

  # nvme list -v
  NVM Express Subsystems

  Subsystem        Subsystem-NQN                                                                                    Controllers
  ---------------- ------------------------------------------------------------------------------------------------ ----------------
  nvme-subsys0     nqn.2014.08.org.nvmexpress:8086108ePHLE7200015N6P4BGN-17335943:ICDPC5ED2ORA6.4T                  nvme0
  nvme-subsys1     nqn.2014.08.org.nvmexpress:8086108ePHLE7200015N6P4BGN-27335943:ICDPC5ED2ORA6.4T                  nvme1
  nvme-subsys2     testnqn                                                                                          nvme2, nvme3

  NVM Express Controllers

  Device   SN                   MN                                       FR       TxPort Address        Subsystem    Namespaces
  -------- -------------------- ---------------------------------------- -------- ------ -------------- ------------ ----------------
  nvme0    PHLE7200015N6P4BGN-1 7335943:ICDPC5ED2ORA6.4T                 QDV1RD07 pcie   0000:88:00.0   nvme-subsys0 nvme0n1
  nvme1    PHLE7200015N6P4BGN-2 7335943:ICDPC5ED2ORA6.4T                 QDV1RD03 pcie   0000:89:00.0   nvme-subsys1 nvme1n1
  nvme2    9eb72cbeecc6fdb0     Linux                                    5.3.0-rc loop                  nvme-subsys2 nvme2n1, nvme2n2
  nvme3    9eb72cbeecc6fdb0     Linux                                    5.3.0-rc loop                  nvme-subsys2 nvme2n1, nvme2n2

  NVM Express Namespaces

  Device       NSID     Usage                      Format           Controllers
  ------------ -------- -------------------------- ---------------- ----------------
  nvme0n1      1          3.20  TB /   3.20  TB    512   B +  0 B   nvme0
  nvme1n1      1          3.20  TB /   3.20  TB    512   B +  0 B   nvme1
  nvme2n1      1          3.20  TB /   3.20  TB    512   B +  0 B   nvme2, nvme3
  nvme2n2      2          3.20  TB /   3.20  TB    512   B +  0 B   nvme2, nvme3


