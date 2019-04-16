Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFB9C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6235E205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbfDPMty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 08:49:54 -0400
Received: from mx0b-00191d01.pphosted.com ([67.231.157.136]:40574 "EHLO
        mx0a-00191d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726796AbfDPMty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 08:49:54 -0400
X-Greylist: delayed 2264 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Apr 2019 08:49:53 EDT
Received: from pps.filterd (m0049462.ppops.net [127.0.0.1])
        by m0049462.ppops.net-00191d01. (8.16.0.27/8.16.0.27) with SMTP id x3GC5rE5041088;
        Tue, 16 Apr 2019 08:11:54 -0400
Received: from alpi155.enaf.aldc.att.com (sbcsmtp7.sbc.com [144.160.229.24])
        by m0049462.ppops.net-00191d01. with ESMTP id 2rwe1vh5cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Apr 2019 08:11:53 -0400
Received: from enaf.aldc.att.com (localhost [127.0.0.1])
        by alpi155.enaf.aldc.att.com (8.14.5/8.14.5) with ESMTP id x3GCBr6E025673;
        Tue, 16 Apr 2019 08:11:53 -0400
Received: from zlp30496.vci.att.com (zlp30496.vci.att.com [135.46.181.157])
        by alpi155.enaf.aldc.att.com (8.14.5/8.14.5) with ESMTP id x3GCBkJ4025562
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 16 Apr 2019 08:11:46 -0400
Received: from zlp30496.vci.att.com (zlp30496.vci.att.com [127.0.0.1])
        by zlp30496.vci.att.com (Service) with ESMTP id 6EFA7400AF93;
        Tue, 16 Apr 2019 12:11:46 +0000 (GMT)
Received: from tlpd252.dadc.sbc.com (unknown [135.31.184.157])
        by zlp30496.vci.att.com (Service) with ESMTP id 589D1400AF91;
        Tue, 16 Apr 2019 12:11:46 +0000 (GMT)
Received: from dadc.sbc.com (localhost [127.0.0.1])
        by tlpd252.dadc.sbc.com (8.14.5/8.14.5) with ESMTP id x3GCBk3N034183;
        Tue, 16 Apr 2019 07:11:46 -0500
Received: from mail.eng.vyatta.net (mail.eng.vyatta.net [10.156.50.82])
        by tlpd252.dadc.sbc.com (8.14.5/8.14.5) with ESMTP id x3GCBepL033996;
        Tue, 16 Apr 2019 07:11:40 -0500
Received: from [10.156.47.86] (unknown [10.156.47.86])
        by mail.eng.vyatta.net (Postfix) with ESMTPA id A921A360045;
        Tue, 16 Apr 2019 05:11:38 -0700 (PDT)
Reply-To: mmanning@vyatta.att-mail.com
Subject: Re: some trouble when using vrf
To:     linmiaohe <linmiaohe@huawei.com>,
        David Ahern <dsa@cumulusnetworks.com>, shrijeet@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mingfangsen <mingfangsen@huawei.com>
References: <15adf635-a74b-e9e3-5dad-b35890f0a746@huawei.com>
From:   Mike Manning <mmanning@vyatta.att-mail.com>
Message-ID: <1057be5b-8792-cf39-286b-f49bc6286117@vyatta.att-mail.com>
Date:   Tue, 16 Apr 2019 13:11:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <15adf635-a74b-e9e3-5dad-b35890f0a746@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-16_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904160083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2019 12:26, linmiaohe wrote:
> Hi all:
>     I meet some trouble when using vrf, it's very nice of you if you
> can help me fix it.
>
>     1.If I bind a vrf address before I set SO_BINDTODEVICE opts to bind an
> enslaved device, "Cannot assign requested address" will occurs. It's
> because only after we set SO_BINDTODEVICE opts to bind an enslaved device,
> then we can lookup the route in the specified l3mdev domain.
>     I think we couldn't limit the order of bind ip addr and SO_BINDTODEVICE opts
> otherwise many vrf unaware apps many need to change their code.
>     I can't find a convenient way to fix it.Here is an example:
>
>     ...
>     bind(sock_fd, (struct sockaddr *)&addr_serv, sizeof(addr_serv));
>     ...
>     ret = setsockopt(sock_fd, SOL_SOCKET, SO_BINDTODEVICE, bind_dev, strlen(bind_dev)+1);
>     ...
>     This code snipet doesn't work if the ip address of addr_serv is not in default vrf. And
> "Cannot assign requested address" will occurs.
Or you can run instances of vrf-unaware applications per VRF with 'sudo
ip vrf exec <vrf> <cmd>', with the 3 sysctl you indicate below set to 0.
>     2.When I run a udp server in default vrf and set net.ipv4.udp_l3mdev_accept=1,
> it's supposed to work accorss VRFs.
>     But it occurs when udp server received a packet, it sends back with the source
> ip address from default vrf which is supposed to from the specified l3mdev domain.
> And the connection between server and client is broken. It's because udp server
> run in default vrf and doesn't bind the enslaved device, so only the route table in
> default vrf is avaliable.
>
>     For example,I run a udp server in default vrf and set net.ipv4.udp_l3mdev_accept=1:
>     [root@localhost vrf]# sysctl -a | grep l3mdev
>     net.ipv4.raw_l3mdev_accept = 1
>     net.ipv4.tcp_l3mdev_accept = 1
>     net.ipv4.udp_l3mdev_accept = 1
>
>     Then connect the server and send a udp packet to the specified vrf. Here is tcpdump output:
>     17:28:54.925417 IP 10.0.0.2.43003 > 10.0.0.1.irdmi: UDP, length 17
>     17:28:54.925953 IP 9.85.153.236.irdmi > 10.0.0.2.43003: UDP, length 17
>     ps. 10.0.0.2 is client ip, 10.0.0.1 is specified vrf ip, and 9.85.153.236 is default vrf ip.
>     10.0.0.1 and 9.85.153.236 are in the same host.
>
> Thanks a lot if you can help me fix these. Have a nice day.
>
>
>

