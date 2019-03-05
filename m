Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD86C00319
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE0D206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cyrv5eKn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfCELKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 06:10:51 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:60176 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfCELKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 06:10:51 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x25B3gat056237;
        Tue, 5 Mar 2019 11:10:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=JMxHhj1KoC/VFlWTRhVGF7HvdNBK4Tx/VdQFdhmUIqE=;
 b=Cyrv5eKnxF2Np/JH4xJ/EqRUc9jxXaF33EynhqKUHpCPMluldavdgate5/1HstZ0tJrW
 UVN33DQxZFukh3F6xCWSlf06gCz9OQKNic8RF74hN1HMqu6m/wLd5YWIobFfPGIxeTBP
 dNwC1FtBzrkB2y+R0HuXz2b9P/vSjOYcmw5Y17JttG+lXoaTT9AgjAH5anRDBcEb/aNv
 UpW+Lj2bpB56UvpkIGrQqF+NzCgx53CDLDyHViGlP4SZLh8Y2CSvhlWj2BFdGSVyhXl8
 Hsk2LFRhsyY5QscyxqDlDL5v0Nubqsf0olof0Lvu621nuWJeGrgJRsdoK+ujjdnzmtfK kA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2qyfbe4x7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Mar 2019 11:10:42 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x25BAf26029846
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Mar 2019 11:10:41 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x25BAe1m013934;
        Tue, 5 Mar 2019 11:10:40 GMT
Received: from kadam (/197.157.34.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 Mar 2019 03:10:40 -0800
Date:   Tue, 5 Mar 2019 14:10:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ian Abbott <abbotti@mev.co.uk>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "Spencer E . Olson" <olsonse@umich.edu>
Subject: Re: [PATCH] staging: comedi: ni_mio_common: Fix divide-by-zero for
 DIO cmdtest
Message-ID: <20190305081629.GA13474@kadam>
References: <20190304143354.4964-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304143354.4964-1-abbotti@mev.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9185 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903050077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 02:33:54PM +0000, Ian Abbott wrote:
> `ni_cdio_cmdtest()` validates Comedi asynchronous commands for the DIO
> subdevice (subdevice 2) of supported National Instruments M-series
> cards.  It is called when handling the `COMEDI_CMD` and `COMEDI_CMDTEST`
> ioctls for this subdevice.  There are two causes for a possible
> divide-by-zero error when validating that the `stop_arg` member of the
> passed-in command is not too large.
> 
> The first cause for the divide-by-zero is that calls to
> `comedi_bytes_per_scan()` are only valid once the command has been
> copied to `s->async->cmd`, but that copy is only done for the
> `COMEDI_CMD` ioctl.  For the `COMEDI_CMDTEST` ioctl, it will use
> whatever was left there by the previous `COMEDI_CMD` ioctl, if any.
> (This is very likely, as it is usual for the application to use
> `COMEDI_CMDTEST` before `COMEDI_CMD`.) If there has been no previous,
> valid `COMEDI_CMD` for this subdevice, then `comedi_bytes_per_scan()`
> will return 0, so the subsequent division in `ni_cdio_cmdtest()` of
> `s->async->prealloc_bufsz / comedi_bytes_per_scan(s)` will be a
> divide-by-zero error.  To fix this error, call a new function
> `comedi_bytes_per_scan_cmd(s, cmd)`, based on the existing
> `comedi_bytes_per_scan(s)` but using a specified `struct comedi_cmd` for
> its calculations.  (Also refactor `comedi_bytes_per_scan()` to call the
> new function.)
> 
> Once the first cause for the divide-by-zero has been fixed, the second
> cause is that `comedi_bytes_per_scan_cmd()` can legitimately return 0 if
> the `scan_end_arg` member of the `struct comedi_cmd` being tested is 0.
> Fix it by only performing the division (and validating that `stop_arg`
> is no more than the maximum value) if `comedi_bytes_per_scan_cmd()`
> returns a non-zero value.
> 
> The problem was reported on the COMEDI mailing list here:
> https://groups.google.com/forum/#!topic/comedi_list/4t9WlHzMhKM
> 

Can you give Ivan a Reported-by tag?  It's a public mailing list so
that shouldn't be a problem.

> Fixes: f164cbf98fa8 ("staging: comedi: ni_mio_common: add finite regeneration to dio output")
> Cc: <stable@vger.kernel.org> # 4.6+
> Cc: Spencer E. Olson <olsonse@umich.edu>
> Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
> ---

regards,
dan carpenter


