Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E222AC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42E320640
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nR+CbgGF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387526AbfJAL4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:56:13 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56862 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfJAL4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:56:12 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x91BsCOJ164303;
        Tue, 1 Oct 2019 11:54:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=BhN0A4ZjzhxzoC7wkUWrOhf6S9z0K6FDpK47i4TJ/6I=;
 b=nR+CbgGFpLQPQTF1hG1HjFhRONS8OkleTBHkUSeTVoki/NKtzxsKuiOxC7jENjM7NI0e
 8ei6XKTUmBZGj5TAxII9KkdKMn03GhlX2InC/qOs2gCXGZN7pEROHyOSpJtzUSnw6eqW
 7TII6UZlAGzFGU+kdJq5C+x1mgXCOHnbAQ3X0MI6gJKAbCb04Txvpf2r5s8QEL6LFXr0
 EJg/22VoeqfzHZpWiiJtd/GlKwsj1BS4WS9rCDj/aOuEOE+VpNbh7LtuBNJYtZoJUKtc
 /VQb0eAFIGn2tX8AoXC//QJEviB4YsCFsqiyY6hiRLlC5poHBcTy94hsVMrAU6DpLt1L Gw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2v9xxuna3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 11:54:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x91Bs3Jc130979;
        Tue, 1 Oct 2019 11:54:50 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2vbnqcrsen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 11:54:50 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x91BsnJE004496;
        Tue, 1 Oct 2019 11:54:49 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Oct 2019 04:54:48 -0700
Date:   Tue, 1 Oct 2019 14:54:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: Fix a signedness bug in
 tcpm_fw_get_caps()
Message-ID: <20191001115442.GB22609@kadam>
References: <20190925110219.GN3264@mwanda>
 <20190926125310.GA9967@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926125310.GA9967@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910010110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910010110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 05:53:10AM -0700, Guenter Roeck wrote:
> On Wed, Sep 25, 2019 at 02:02:19PM +0300, Dan Carpenter wrote:
> > The "port->typec_caps.data" and "port->typec_caps.type" variables are
> > enums and in this context GCC will treat them as an unsigned int so they
> > can never be less than zero.
> > 
> > Fixes: ae8a2ca8a221 ("usb: typec: Group all TCPCI/TCPM code together")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/usb/typec/tcpm/tcpm.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> > index 96562744101c..d3b63e000ae2 100644
> > --- a/drivers/usb/typec/tcpm/tcpm.c
> > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > @@ -4410,7 +4410,7 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
> >  	ret = fwnode_property_read_string(fwnode, "data-role", &cap_str);
> >  	if (ret == 0) {
> >  		port->typec_caps.data = typec_find_port_data_role(cap_str);
> > -		if (port->typec_caps.data < 0)
> > +		if ((int)port->typec_caps.data < 0)
> >  			return -EINVAL;
> 
> Doesn't that also cause a warning about overwriting error return codes ?

I'm happy that you think there is a tool which generates warnings like
that but it's just people manually complaining.  :P

I'll resend though.

regards,
dan carpenter
