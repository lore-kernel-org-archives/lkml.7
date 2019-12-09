Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9ADC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 12:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD3B207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 12:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Mq4rx6xz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfLIMRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 07:17:53 -0500
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:49186 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfLIMRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 07:17:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1575893873;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IdHWmdL89AFTcNn7gde3T6zcfIwKQtkIaBfK83eXzJg=;
  b=Mq4rx6xzOtoR+R+vK+h+2pJq/jbpfhX06PbZAtfUsnDvbM6V3OKjoa/k
   /o/QVD3yW4TwVfTwTLaoCOVPr/qWkU4fWgn0Z/4DfND38Ard5MXWIQOh6
   +fMXbbNpSFEv7xji3ZrmsD9AwejPY7vUpty9FqDTkSU49liDV2L8Q5rt3
   E=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=roger.pau@citrix.com; spf=Pass smtp.mailfrom=roger.pau@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
  receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa3.hc3370-68.iphmx.com: domain of
  roger.pau@citrix.com designates 162.221.158.21 as permitted
  sender) identity=mailfrom; client-ip=162.221.158.21;
  receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: Ey51vp+2KYMhnR/IHTgER0g3Mtxd0Qo8m927IbKqqJ3MMCfmZnXdP4SNrKUaLXuHmz9QoWHU7p
 tcgVTLvgKK0WrLpkFPm32ByYJQUF0aBX+L3dxNhbw/jq1CrVXlCldWJ4ClvB/AwCl7LJq2Mh57
 Ij4dLm6kkHCFszc9mKHAtDhxg974LO2iDrW0auUrHRxoJsqENg9/hBFwKwSWEu3aNn5Jycaace
 KxcJ27/BOiwciiOK4shXPPIlNzZJnsDhqSQWezGKxmJoaDAcW/Q+YqgoBZY2NAAMPpi6FF1bhu
 QL4=
X-SBRS: 2.7
X-MesageID: 9387524
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,294,1571716800"; 
   d="scan'208";a="9387524"
Date:   Mon, 9 Dec 2019 13:17:26 +0100
From:   Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To:     Paul Durrant <pdurrant@amazon.com>
CC:     <linux-kernel@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH 4/4] xen-blkback: support dynamic unbind/bind
Message-ID: <20191209121726.GU980@Air-de-Roger>
References: <20191205140123.3817-1-pdurrant@amazon.com>
 <20191205140123.3817-5-pdurrant@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191205140123.3817-5-pdurrant@amazon.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL03.citrite.net (10.69.22.127)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 02:01:23PM +0000, Paul Durrant wrote:
> By simply re-attaching to shared rings during connect_ring() rather than
> assuming they are freshly allocated (i.e assuming the counters are zero)
> it is possible for vbd instances to be unbound and re-bound from and to
> (respectively) a running guest.
> 
> This has been tested by running:
> 
> while true; do dd if=/dev/urandom of=test.img bs=1M count=1024; done
> 
> in a PV guest whilst running:
> 
> while true;
>   do echo vbd-$DOMID-$VBD >unbind;
>   echo unbound;
>   sleep 5;
>   echo vbd-$DOMID-$VBD >bind;
>   echo bound;
>   sleep 3;
>   done

So this does unbind blkback while leaving the PV interface as
connected?

Thanks, Roger.
