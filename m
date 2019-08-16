Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407E6C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 16:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E4E2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 16:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfHPQ5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 12:57:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:38960 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfHPQ5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 12:57:36 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 09:57:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,393,1559545200"; 
   d="p7s'?scan'208";a="377473207"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga006.fm.intel.com with ESMTP; 16 Aug 2019 09:57:33 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.157]) by
 ORSMSX105.amr.corp.intel.com ([169.254.2.226]) with mapi id 14.03.0439.000;
 Fri, 16 Aug 2019 09:57:32 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH V5 2/2] genirq/affinity: Spread vectors on node
 according to nr_cpu ratio
Thread-Topic: [PATCH V5 2/2] genirq/affinity: Spread vectors on node
 according to nr_cpu ratio
Thread-Index: AQHVU9psjM6wSf+XJ0+m2YnyixKONKb+Yz6AgAARyQA=
Date:   Fri, 16 Aug 2019 16:57:32 +0000
Message-ID: <3bdaa2bbd7b7c7e4cd15bee6f8df074df1fc1077.camel@intel.com>
References: <20190816022849.14075-1-ming.lei@redhat.com>
         <20190816022849.14075-3-ming.lei@redhat.com>
         <20190816155353.GA6883@localhost.localdomain>
In-Reply-To: <20190816155353.GA6883@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.115.165]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-CpnwSnP8CWQo8USLaSEZ"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-CpnwSnP8CWQo8USLaSEZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-08-16 at 09:53 -0600, Keith Busch wrote:
> On Thu, Aug 15, 2019 at 07:28:49PM -0700, Ming Lei wrote:
> > Now __irq_build_affinity_masks() spreads vectors evenly per node, and
> > all vectors may not be spread in case that each numa node has different
> > CPU number, then the warning in irq_build_affinity_masks() can
> > be triggered.
> >=20
> > Improve current spreading algorithm by assigning vectors according to
> > the ratio of node's nr_cpu to nr_remaining_cpus, meantime running the
> > assignment from smaller nodes to bigger nodes to guarantee that every
> > active node gets allocated at least one vector, then we can avoid
> > cross-node spread in normal situation.
> >=20
> > Meantime the reported warning can be fixed.
> >=20
> > Another big goodness is that the spread approach becomes more fair if
> > node has different CPU number.
> >=20
> > For example, on the following machine:
> > 	[root@ktest-01 ~]# lscpu
> > 	...
> > 	CPU(s):              16
> > 	On-line CPU(s) list: 0-15
> > 	Thread(s) per core:  1
> > 	Core(s) per socket:  8
> > 	Socket(s):           2
> > 	NUMA node(s):        2
> > 	...
> > 	NUMA node0 CPU(s):   0,1,3,5-9,11,13-15
> > 	NUMA node1 CPU(s):   2,4,10,12
> >=20
> > When driver requests to allocate 8 vectors, the following spread can
> > be got:
> > 	irq 31, cpu list 2,4
> > 	irq 32, cpu list 10,12
> > 	irq 33, cpu list 0-1
> > 	irq 34, cpu list 3,5
> > 	irq 35, cpu list 6-7
> > 	irq 36, cpu list 8-9
> > 	irq 37, cpu list 11,13
> > 	irq 38, cpu list 14-15
> >=20
> > Without this patch, kernel warning is triggered on above situation, and
> > allocation result was supposed to be 4 vectors for each node.
> >=20
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Keith Busch <kbusch@kernel.org>
> > Cc: linux-nvme@lists.infradead.org,
> > Cc: Jon Derrick <jonathan.derrick@intel.com>
> > Cc: Jens Axboe <axboe@kernel.dk>
> > Reported-by: Jon Derrick <jonathan.derrick@intel.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
>=20
> I had every intention to thoroughly test this on imbalanced node
> configurations, but that's not going to happen anytime soon. It looks
> correct to me, so I'll append my review here.
>=20
I can only test this with 2 nodes but I have varied nr_cpus as well as
using different devices with fewer and more vectors than CPUs. Spread
looks good.

Thank you

Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>


[snip]

--=-CpnwSnP8CWQo8USLaSEZ
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

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
PNauajAtxgRKfqfSMb+IcL/VXiPtVZOxVq+CTZeDJkaEmn/79vg8OYxpR+YhFF+tGlKf/Zc4id1P
AgMBAAGjggI3MIICMzAdBgNVHQ4EFgQU4oawcWXM1cPGdwGcIszDfjORVZAwHwYDVR0jBBgwFoAU
HmkqtNwo/kcYTiELP7ysES/wmPUwZQYDVR0fBF4wXDBaoFigVoZUaHR0cDovL3d3dy5pbnRlbC5j
b20vcmVwb3NpdG9yeS9DUkwvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWluZyUyMENB
JTIwNEEuY3JsMIGfBggrBgEFBQcBAQSBkjCBjzBpBggrBgEFBQcwAoZdaHR0cDovL3d3dy5pbnRl
bC5jb20vcmVwb3NpdG9yeS9jZXJ0aWZpY2F0ZXMvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIw
SXNzdWluZyUyMENBJTIwNEEuY3J0MCIGCCsGAQUFBzABhhZodHRwOi8vb2NzcC5pbnRlbC5jb20v
MAsGA1UdDwQEAwIHgDA8BgkrBgEEAYI3FQcELzAtBiUrBgEEAYI3FQiGw4x1hJnlUYP9gSiFjp9T
gpHACWeB3r05lfBDAgFkAgEJMB8GA1UdJQQYMBYGCCsGAQUFBwMEBgorBgEEAYI3CgMMMCkGCSsG
AQQBgjcVCgQcMBowCgYIKwYBBQUHAwQwDAYKKwYBBAGCNwoDDDBRBgNVHREESjBIoCoGCisGAQQB
gjcUAgOgHAwaam9uYXRoYW4uZGVycmlja0BpbnRlbC5jb22BGmpvbmF0aGFuLmRlcnJpY2tAaW50
ZWwuY29tMA0GCSqGSIb3DQEBBQUAA4IBAQBxGkHe05DNpYel4b9WbbyQqD1G6y6YA6C93TjKULZi
p8+gO1LL096ixD44+frVm3jtXMikoadRHQJmBJdzsCywNE1KgtrYF0k4zRWr7a28nyfGgQe4UHHD
7ARyZFeGd7AKSQ1y4/LU57I2Aw2HKx9/PXavv1JXjjO2/bqTfnZDJTQmOQ0nvlO3/gvbbABxZHqz
NtfHZsQWS7s+Elk2xGUQ0Po2pMCQoaPo9R96mm+84UP9q3OvSqMoaZwfzoUeAx2wGJYl0h3S+ABr
CPVfCgq9qnmVCn5DyHWE3V/BRjJCoILLBLxAxnmSdH4pF6wJ6pYRLEw9qoyNhpzGUIJU/Lk1MYIC
FzCCAhMCAQEwgZAweTELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRQwEgYDVQQHEwtTYW50YSBD
bGFyYTEaMBgGA1UEChMRSW50ZWwgQ29ycG9yYXRpb24xKzApBgNVBAMTIkludGVsIEV4dGVybmFs
IEJhc2ljIElzc3VpbmcgQ0EgNEECEzMAAMamAkocC+WQNPgAAAAAxqYwCQYFKw4DAhoFAKBdMBgG
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDgxNjE2NTczMlowIwYJ
KoZIhvcNAQkEMRYEFGJ0tA4QcP88ZIQAAotLYxr/F6sGMA0GCSqGSIb3DQEBAQUABIIBABUVYqnO
tPAV2MlSwV41bly24I+ht/sj9CO/c0apJlJn+P5ho0m0CgrYGtz3nOlb9SDqMW6XObjl/gSK8rJ0
dk4Gi9VdPTFuc/Xj8kscNlwtfrfpR3O5AE7WYDsx5krA5fT9aDpoxql+Pn2kxM5rcBJiJJeUClxn
szANn23Mf7z4GoxrSrK63T1CGCavZR8sSDyq8Y1iJevtHcLfAPVkFTTRpZw3c6IEbthlK2Unol72
AHVirSxuFJwGg1GpVG0+jOatZ0PmQ0UOe0dzA5Ovil2mhX4KnvauqkNhjWWU5tNHUDgwKJb1t0BB
zOeSULi/LYM2NYx7e7tbF1lMMFB4GPEAAAAAAAA=


--=-CpnwSnP8CWQo8USLaSEZ--
