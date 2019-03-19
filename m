Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C8FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28CA2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ncIzX9y5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfCSQZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:25:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43332 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbfCSQZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:25:33 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2JGOLuW155816;
        Tue, 19 Mar 2019 16:25:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=boiVMvI1agSldOJ3tT9DlTKfPJR+c6j/betIWYfvZ3c=;
 b=ncIzX9y5Zw4CwmGhd+WN5brSUtAv9/OgKgOvo8dDkybxGI0bx8Bth9gFVrUL38k8mg5/
 wlN+R8h+Bkllu+z0oNH1DfSXaLTJb76aBmA8+6SCKolGPKkFoSkKLnLK4aUZXw4fVmvZ
 us0Xb5l//ge3pwI+NZLfWdsuhiZ31/pAU7myrh3z3LQkEPW2XEt5tMZbP+b7oIcoQOv9
 rRigVpjtedK7zIbcBh7+Wg8F45VG7rElvtnM8QnPk/EIG2w605Jxb9crLcC51LU3SOul
 PSjyGsJIURYYhHOtThYfviD+WGsxaEcayDOajU3nrmf5JG/ZrH4KEFXsEYlX4nEyeq1J 5A== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2r8ssrdrg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 16:25:22 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2JGPMlS008650
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 16:25:22 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2JGPLTE008326;
        Tue, 19 Mar 2019 16:25:21 GMT
Received: from lap1 (/77.138.186.148)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Mar 2019 09:25:21 -0700
Date:   Tue, 19 Mar 2019 18:25:15 +0200
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Boris Pismenny <borisp@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        Wei Yongjun <weiyongjun1@huawei.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: mlx5: Add a missing check on idr_find, free buf
Message-ID: <20190319162514.GG32657@lap1>
References: <20190319162406.7525-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319162406.7525-1-pakki001@umn.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9200 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903190120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 11:24:02AM -0500, Aditya Pakki wrote:
> idr_find() can return a NULL value to 'flow' which is used without a check.
> The patch adds a check to avoid potential NULL pointer dereference.
> In case of mlx5_fpga_sbu_conn_sendmsg() failure, free buf allocated
> using kzalloc.
> 
> ---
> Fixes: ab412e1dd7db ('net/mlx5: Accel, add TLS rx offload routines')

This should be part of the commit message

> v2: failure to return in case of flow failure.
> v1: Failed to free buf in case of flow failure.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c b/drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c
> index 5cf5f2a9d51f..224e0d7f6489 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c
> @@ -226,6 +226,11 @@ int mlx5_fpga_tls_resync_rx(struct mlx5_core_dev *mdev, u32 handle, u32 seq,
>  	rcu_read_lock();
>  	flow = idr_find(&mdev->fpga->tls->rx_idr, ntohl(handle));
>  	rcu_read_unlock();
> +	if (!flow) {
> +		WARN_ONCE(1, "Received NULL pointer for handle\n");
> +		kfree(buf);
> +		return -EINVAL;
> +	}
>  	mlx5_fpga_tls_flow_to_cmd(flow, cmd);
>  
>  	MLX5_SET(tls_cmd, cmd, swid, ntohl(handle));
> @@ -238,6 +243,8 @@ int mlx5_fpga_tls_resync_rx(struct mlx5_core_dev *mdev, u32 handle, u32 seq,
>  	buf->complete = mlx_tls_kfree_complete;
>  
>  	ret = mlx5_fpga_sbu_conn_sendmsg(mdev->fpga->tls->conn, buf);
> +	if (ret < 0)
> +		kfree(buf);
>  
>  	return ret;
>  }
> -- 
> 2.17.1
> 
