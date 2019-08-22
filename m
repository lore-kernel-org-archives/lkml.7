Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD916C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 18:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A802173E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 18:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FD6hFNRk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391049AbfHVSoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 14:44:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56086 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731043AbfHVSoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 14:44:05 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7MIhRYE110852;
        Thu, 22 Aug 2019 18:43:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=9fkQalzvJmXiikKkvFFw4wgr8lo9ZeYd+D7xrjBxOpE=;
 b=FD6hFNRksHsjBT9z4RE6Rnopb0nS07WsbnJ01gc/rMh7ym66bFbwCB3FHitVF0vQgGXt
 uzDvqMSWbFF4GAL5JOMdvV9d0AvxZSqW2DbTsJotrZ8N6NCKKL+PW9oC4TDqFJMhTGYD
 X6Z+o1ZmwvCQKWXoxUBkwIMIiwDcHNFMLgYME67nZHGbPhEF4p8pHzEcFPu/Ey3X7iv3
 eVLYw+8HqKn7G8CdAnXQebhrK1NfPhm68ab0LqNVF1wi++crOgkWattejtCw7uyKGd28
 x7AAjKMf48RohI/AqQjJlCfmJUsIleOb/mulDLWrFs2f5BBLvp5yt2cQZbtUYkQrj/OD 5w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2ue90tyxfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Aug 2019 18:43:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7MIgamj023486;
        Thu, 22 Aug 2019 18:43:50 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2uh83qeaxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Aug 2019 18:43:49 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7MIhm8h011045;
        Thu, 22 Aug 2019 18:43:48 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 22 Aug 2019 11:43:48 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id D56D66A0141; Thu, 22 Aug 2019 14:45:39 -0400 (EDT)
Date:   Thu, 22 Aug 2019 14:45:39 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        jmattson@redhat.com, ehabkost@redhat.com
Subject: Re: [PATCH 3/3] KVM: x86: use Intel speculation bugs and features as
 derived in generic x86 code
Message-ID: <20190822184539.GB9964@char.us.oracle.com>
References: <1566376002-17121-1-git-send-email-pbonzini@redhat.com>
 <1566376002-17121-4-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566376002-17121-4-git-send-email-pbonzini@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9357 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=932
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908220163
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9357 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908220163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 10:26:42AM +0200, Paolo Bonzini wrote:
> Similar to AMD bits, set the Intel bits from the vendor-independent
> feature and bug flags, because KVM_GET_SUPPORTED_CPUID does not care
> about the vendor and they should be set on AMD processors as well.
> 
> Suggested-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thank you!
